import 'package:barchart/Testing/config.dart';
import 'package:barchart/Testing/constraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:barchart/Testing/bars.dart';
import 'package:barchart/Testing/transformation.dart';
import 'package:barchart/Testing/cursor.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class BarChart extends HookConsumerWidget {
  const BarChart({super.key});

  void transformToBar({required int barIndex, required WidgetRef ref}){
    final bars = ref.read(BarChartGlobalBars.activeBars);
    if (barIndex < 0 || barIndex >= bars.length){
      return;
    }

    final bar = bars[barIndex];
    final barYValue = bar.yValue;

    final yDistance = ref.read(BarChartGlobalBars.yDistance);
    final barChartHeight = ref.read(BarChartGlobalConstraints.constraints).barChartSize.height;
    final config = ref.read(BarChartGlobalConfig.configNotifier);
    final barWidth = config.barWidth;
    final barSpacing = config.barXSpacing;
    final minY = ref.read(BarChartGlobalBars.minYValue);

    final center = yDistance - minY.abs();
    final x = barIndex * (barWidth + barSpacing);
    final y = (barYValue >= 0.0) ? ((center - barYValue) / yDistance) * barChartHeight : (center / yDistance) * barChartHeight;
    final scale = 1.0 / (barYValue.abs() / yDistance);
    
    final transform = Matrix4.identity();
    transform.scaleByDouble(scale, scale, scale, 1.0);
    transform.translateByVector3(Vector3(-x, -y, 0.0));

    ref.read(BarChartGlobalTransformation.transformation.notifier).set(transformation: transform);

  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bars = ref.watch(BarChartGlobalBars.activeBars);
    final config = ref.watch(BarChartGlobalConfig.configNotifier);
    final barWidth = config.barWidth;
    final barXSpacing = config.barXSpacing;

    final transformation = ref.watch(BarChartGlobalTransformation.transformation);
    final transformController = useTransformationController(initialValue: transformation);
    // ensures when the viewer is transformed, the global transformation is notified.
    useEffect((){
      void updateTransformMatrix(){
        if (transformController.value != transformation){
          ref.read(BarChartGlobalTransformation.transformation.notifier).set(transformation: transformController.value);
        }

      }

      transformController.addListener(updateTransformMatrix);

      return (){
        transformController.removeListener(updateTransformMatrix);
      };

    }, [transformController]);
    // ensures when the global transformation is transformed, the controller is notified.
    useEffect((){

      WidgetsBinding.instance.addPostFrameCallback((_){
        if (transformController.value != transformation){
          transformController.value = transformation;
        }
      });

      return null;
    }, [transformation]);

    final maxYValue = ref.watch(BarChartGlobalBars.maxYValue);
    final minYValue = ref.watch(BarChartGlobalBars.minYValue);

    // the only way distance can be 0 is if there are no bars, or all the bars
    // have a yValue of 0, which means they shouldn't show anyway.
    final distance = ref.watch(BarChartGlobalBars.yDistance);

    final zeroFromTopUnit = (distance > 0.0) ? maxYValue.abs() / distance : 0.0;
    final zeroFromBottomUnit = (distance > 0.0) ? minYValue.abs() / distance : 0.0;

    return LayoutBuilder(builder: (context, constraints) {

      final zeroFromTop = zeroFromTopUnit * constraints.maxHeight;
      final zeroFromBottom = zeroFromBottomUnit * constraints.maxHeight;
      final unitDistance = (distance > 0.0) ? constraints.maxHeight / distance : 1.0;

      return Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (details){
          ref.read(BarChartGlobalCursor.barChartCursorOffset.notifier).set(value: details.localPosition);
        },
        onPointerHover: (details){
          ref.read(BarChartGlobalCursor.barChartCursorOffset.notifier).set(value: details.localPosition);
        },
        onPointerCancel: (details){
          if (details.localPosition.dx >= 0.0 && details.localPosition.dx <= constraints.maxWidth && details.localPosition.dy  >= 0.0 && details.localPosition.dy < constraints.maxHeight){
            ref.read(BarChartGlobalCursor.barChartCursorOffset.notifier).set(value: details.localPosition);
          }
          else{
            ref.read(BarChartGlobalCursor.barChartCursorOffset.notifier).set(value: null);
          }
        },
        onPointerMove: (details){
          if (details.localPosition.dx >= 0.0 && details.localPosition.dx <= constraints.maxWidth && details.localPosition.dy  >= 0.0 && details.localPosition.dy < constraints.maxHeight){
            ref.read(BarChartGlobalCursor.barChartCursorOffset.notifier).set(value: details.localPosition);
          }
          else{
            ref.read(BarChartGlobalCursor.barChartCursorOffset.notifier).set(value: null);
          }
        },
        child: MouseRegion(
          hitTestBehavior: HitTestBehavior.translucent,
          onExit: (details){
            ref.read(BarChartGlobalCursor.barChartCursorOffset.notifier).set(value: null);
          },

          child: GestureDetector(
            onDoubleTap: (){
              final xIndex = ref.read(BarChartGlobalCursor.hoveringOverXIndex);
              if (xIndex == null) return;

              final overYValue = ref.read(BarChartGlobalCursor.hoveringOverYValue);
              if (overYValue == null) return;

              final bar = bars[xIndex];
              final topY = bar.yValue < 0.0 ? 0.0 : bar.yValue;
              final bottomY = bar.yValue < 0.0 ? bar.yValue : 0.0;

              if (overYValue < bottomY || overYValue > topY) return;

              transformToBar(barIndex: xIndex, ref: ref);


            },
            child: InteractiveViewer(
                //boundaryMargin: EdgeInsets.only(right: double.infinity),
                boundaryMargin: EdgeInsets.only(
                    right: ((barWidth + barXSpacing) * bars.length) + constraints.maxWidth,
                    top: constraints.maxHeight / (config.leftPanelValueCount + 1),
                    bottom: constraints.maxHeight / (config.leftPanelValueCount + 1)
                ),
                minScale: double.minPositive,
                maxScale: double.maxFinite,
                transformationController: transformController,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    for (final (index, bar) in bars.indexed)
                      Positioned(
                          left: barWidth * index + (barXSpacing * index),
                          top: (bar.yValue < 0) ? zeroFromTop : null,
                          bottom: (bar.yValue >= 0) ? zeroFromBottom : null,
                          child: SizedBox(
                            width: barWidth,
                            height: bar.yValue.abs() * unitDistance,
                            child: Container(
                              decoration: BoxDecoration(
                                border: bar.outlined ? Border.all(color: Colors.black, width: bar.outlineWidth) : null,
                                color: bar.color,
                                borderRadius: bar.yValue >= 0.0
                                    ? BorderRadius.only(topLeft: Radius.circular(bar.circularRadius), topRight: Radius.circular(bar.circularRadius))
                                    : BorderRadius.only(bottomLeft: Radius.circular(bar.circularRadius), bottomRight: Radius.circular(bar.circularRadius))
                                //borderRadius: BorderRadius.circular(20)
                              ),

                            ),
                          )
                      )
                  ],
                )
            ),
          ),
        ),
      );

    });
  }
}
