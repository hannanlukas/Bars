import 'package:barchart/Testing/config.dart';
import 'package:barchart/Testing/constraints.dart';
import 'package:barchart/Testing/transformation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:barchart/Testing/Widgets/menupicker.dart';

class YGridPainterStatic extends CustomPainter{

  const YGridPainterStatic({
    required this.constraints,
    required this.config,
    required this.opacity
  });

  final BarChartConstraints constraints;
  final BarChartConfig config;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {

    final y = constraints.barChartOffset.dy;
    final length = constraints.barChartSize.width;
    final spacing = constraints.barChartSize.height / config.leftPanelValueCount;

    for (int i = 0; i <= config.leftPanelValueCount; ++i){
      canvas.drawLine(
          Offset(0, y + (spacing * i)),
          Offset(length, y + (spacing * i)),
          Paint()..color = Colors.black.withValues(alpha: opacity)..strokeWidth = 1
      );
    }
  }

  @override
  bool shouldRepaint(covariant YGridPainterStatic oldDelegate) {
    return constraints != oldDelegate.constraints || config != oldDelegate.config || opacity != oldDelegate.opacity;
  }


}

class YGridPainterDynamic extends CustomPainter{

  const YGridPainterDynamic({
    required this.constraints,
    required this.config,
    required this.transform,
    required this.centerOffset,
    required this.opacity
  });

  final BarChartConstraints constraints;
  final BarChartConfig config;
  final Matrix4 transform;
  final double centerOffset;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {

    final y = constraints.barChartOffset.dy;
    final length = constraints.barChartSize.width;
    final spacing = constraints.barChartSize.height / config.leftPanelValueCount;
    final remainder = (transform.getTranslation().y + centerOffset) % spacing;

    canvas.drawLine(Offset(0, y), Offset(length, y), Paint()..color = Colors.black.withValues(alpha: opacity)..strokeWidth = 1);
    canvas.drawLine(Offset(0, y + constraints.barChartSize.height), Offset(length, y + constraints.barChartSize.height), Paint()..color = Colors.black.withValues(alpha: opacity)..strokeWidth = 1);


    for (int i = 0; i <= config.leftPanelValueCount; ++i){
      if ((y + remainder) + (spacing * i) <= y + constraints.barChartSize.height){
        canvas.drawLine(
            Offset(0, (y + remainder) + (spacing * i)),
            Offset(length, (y + remainder) + (spacing * i)),
            Paint()..color = Colors.black.withValues(alpha: opacity)..strokeWidth = 1
        );
      }

    }
  }

  @override
  bool shouldRepaint(covariant YGridPainterDynamic oldDelegate) {
    return constraints != oldDelegate.constraints ||
        config != oldDelegate.config ||
        transform != oldDelegate.transform ||
        centerOffset != oldDelegate.centerOffset ||
        opacity != oldDelegate.opacity;
  }


}

class YGrid extends HookConsumerWidget {
  const YGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final constraints = ref.watch(BarChartGlobalConstraints.constraints);
    final config = ref.watch(BarChartGlobalConfig.configNotifier);
    final transform = ref.watch(BarChartGlobalTransformation.transformation);

    final center = ref.watch(BarChartGlobalConstraints.zeroLineYOffset);
    final centerTransformed = (center != null) ? center - transform.getTranslation().y : 0.0;

    if (!config.showYGrid){
      return SizedBox.shrink();
    }

    return CustomPaint(
      painter: (config.staticYGrid)
          ? YGridPainterStatic(constraints: constraints, config: config, opacity: config.yGridOpacity)
          : YGridPainterDynamic(
              centerOffset: centerTransformed,
              transform: transform,
              constraints: constraints,
              config: config,
              opacity: config.yGridOpacity
      ),
    );
  }
}
