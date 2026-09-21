import 'package:barchart/Testing/config.dart';
import 'package:barchart/Testing/constraints.dart';
import 'package:barchart/Testing/cursor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:barchart/Testing/bars.dart';
import 'package:barchart/Testing/transformation.dart';

class XPanel extends HookConsumerWidget {
  const XPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final constraints = ref.watch(BarChartGlobalConstraints.constraints);
    final config = ref.watch(BarChartGlobalConfig.configNotifier);
    final transform = ref.watch(BarChartGlobalTransformation.transformation);
    final bars = ref.watch(BarChartGlobalBars.activeBars);

    final cursorOffset = ref.watch(BarChartGlobalCursor.barChartCursorOffset);
    final cursorXIndex = ref.watch(BarChartGlobalCursor.hoveringOverXIndex);

    //final xPanelHeight = constraints.bottomPanelSize.height;

    final barWidth = config.barWidth;
    final barSpacing = config.barXSpacing;
    final scale = transform.getMaxScaleOnAxis();
    final xOffset = transform.getTranslation().x;

    final scaledBarWidth = config.barWidth * scale;
    final barCenter = (barWidth * scale) / 2.0;

    final barXDistance = (barWidth + barSpacing) * scale;
    final startIndex = (-xOffset / barXDistance).floor();
    final endIndex = ((-xOffset + constraints.barChartSize.width) / barXDistance).floor();
    final screenOffset = -(-xOffset % barXDistance);
    final barsOnScreen = (startIndex < bars.length && endIndex >= 0);

    final fontSize = (config.xValuesFontSize * scale).clamp(0.0, config.xValuesFontSize);

    if (!barsOnScreen || !config.showXValues) {
      return SizedBox.shrink();
    }


    return LayoutBuilder(builder: (context, constraints) {



      return Stack(
        children: [

          for (int i = startIndex; i <= endIndex; ++i)
            Positioned(
                  left: (barXDistance * (i - startIndex)) + screenOffset,
                  top: 10,
                  child: (i >= 0 && i < bars.length)
                      ? (config.rotateXLabels)
                          ? Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Transform.translate(
                                offset: Offset(barCenter, 0),
                                child: FractionalTranslation(
                                  translation: Offset(-0.5, 0),
                                  child: RotatedBox(
                                    quarterTurns: 1,
                                    child: Text(
                                      /*
                                        style: TextStyle(
                                            fontSize: fontSize,
                                            color: config.xValuesFontColor
                                        ),

                                       */
                                        style: GoogleFonts.googleSans(
                                            fontSize: fontSize,
                                            color: config.xValuesFontColor
                                        ),
                                        (config.showLabelsInBottomPanel) ? bars[i].xLabel : bars[i].xValue.toString()
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                          : Transform.translate(
                            offset: Offset(barCenter, 0),
                            child: FractionalTranslation(
                              translation: Offset(-0.5, 0),
                              child: Text(
                                  (config.showLabelsInBottomPanel) ? bars[i].xLabel : bars[i].xValue.toString(),
                                  style: GoogleFonts.googleSans(
                                      fontSize: fontSize,
                                      color: config.xValuesFontColor
                                  ),
                                ),
                            ),
                          )
                      : SizedBox.shrink()
            ),

          if (config.cursorTrackerEnabled && cursorXIndex != null && cursorOffset != null)
            Positioned(
                left: cursorOffset.dx,
                top: 10,
                child: FractionalTranslation(
                  translation: Offset(-0.5, 0),
                  child: SizedBox(
                    width: scaledBarWidth,
                    child: (config.rotateXLabels)
                        ? Stack(
                      children: [
                        Align(
                          alignment: AlignmentGeometry.center,
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Text(
                                (config.showLabelsInBottomPanel) ? bars[cursorXIndex].xLabel : bars[cursorXIndex].xValue.toString(),
                              style: GoogleFonts.googleSans(
                                  fontSize: fontSize,
                                  color: config.xValuesFontColor
                              ),
                            ),
                          ),

                        )
                      ],
                    )
                        : Center(child: Text(
                        style: GoogleFonts.googleSans(
                            fontSize: fontSize,
                            color: config.xValuesFontColor
                        ),
                          bars[cursorXIndex].xValue.toString()),
                    ),
                  ),
                )
            )

        ],
      );
    });
  }
}
