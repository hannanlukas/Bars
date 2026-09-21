import 'package:barchart/Testing/config.dart';
import 'package:barchart/Testing/constraints.dart';
import 'package:barchart/Testing/cursor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:barchart/Testing/bars.dart';
import 'package:barchart/Testing/transformation.dart';

class YPanel extends HookConsumerWidget {
  const YPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final transform = ref.watch(BarChartGlobalTransformation.transformation);
    final barChartConstraints = ref.watch(BarChartGlobalConstraints.constraints);
    final config = ref.watch(BarChartGlobalConfig.configNotifier);
    final leftPanelValueCount = config.leftPanelValueCount;
    final yFloatingPointDigits = config.yValueFloatingPointDigits;
    final maxYValue = ref.watch(BarChartGlobalBars.maxYValue);
    final distance = ref.watch(BarChartGlobalBars.yDistance);

    final cursorOffset = ref.watch(BarChartGlobalCursor.barChartCursorOffset);
    final cursorYValue = ref.watch(BarChartGlobalCursor.hoveringOverYValue);

    if (!config.showYValues){
      return SizedBox.shrink();
    }



    return LayoutBuilder(builder: (context, constraints) {

      final spacing = barChartConstraints.barChartSize.height / leftPanelValueCount;
      final screenUnit = barChartConstraints.barChartSize.height / leftPanelValueCount;

      final topLeftPos = transform.getTranslation();
      final scale = transform.getMaxScaleOnAxis();
      final valueToScreen = (distance / barChartConstraints.barChartSize.height);

      //final topValue = maxYValue + (valueToScreen * (topLeftPos.y / scale));
      //final bottomValue = maxYValue + (valueToScreen * ((topLeftPos.y - barChartConstraints.barChartSize.height) / scale));


      return Stack(
        children: [


          for (int i = 0; i <= leftPanelValueCount; ++i)
            Positioned(
              top: barChartConstraints.barChartOffset.dy + (spacing * i),
              child: FractionalTranslation(
                translation: Offset(0.0, -0.5),
                child: SizedBox(
                  width: constraints.maxWidth,
                  child: Align(
                      alignment: AlignmentGeometry.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text((maxYValue + ((valueToScreen * (topLeftPos.y - (screenUnit * i)) / scale))).toStringAsFixed(yFloatingPointDigits)),
                      )
                  ),
                ),
              ),
            ),

          if (config.cursorTrackerEnabled && cursorYValue != null && cursorOffset != null)
            Positioned(
              top: barChartConstraints.barChartOffset.dy + cursorOffset.dy,
              child: FractionalTranslation(
              translation: Offset(0.0, -0.5),
              child: SizedBox(
                width: constraints.maxWidth,
                child: Align(
                    alignment: AlignmentGeometry.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(cursorYValue.toStringAsFixed(yFloatingPointDigits)),
                    )
                ),
              ),
            ),),



        ],
      );
    });
  }
}

class YPanelUpdated extends HookConsumerWidget {
  const YPanelUpdated({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final transform = ref.watch(BarChartGlobalTransformation.transformation);
    final barChartConstraints = ref.watch(BarChartGlobalConstraints.constraints);
    final config = ref.watch(BarChartGlobalConfig.configNotifier);
    final leftPanelValueCount = config.leftPanelValueCount;
    final yFloatingPointDigits = config.yValueFloatingPointDigits;
    final maxYValue = ref.watch(BarChartGlobalBars.maxYValue);
    final distance = ref.watch(BarChartGlobalBars.yDistance);

    final cursorOffset = ref.watch(BarChartGlobalCursor.barChartCursorOffset);
    final cursorYValue = ref.watch(BarChartGlobalCursor.hoveringOverYValue);

    final spacing = barChartConstraints.barChartSize.height / leftPanelValueCount;
    final center = ref.watch(BarChartGlobalConstraints.zeroLineYOffset);
    final centerTransformed = (center != null) ? center - transform.getTranslation().y : 0.0;
    final remainder = (transform.getTranslation().y + centerTransformed) % spacing;

    if (!config.showYValues){
      return SizedBox.shrink();
    }


    return LayoutBuilder(builder: (context, constraints) {

      final spacing = barChartConstraints.barChartSize.height / leftPanelValueCount;
      final screenUnit = barChartConstraints.barChartSize.height / leftPanelValueCount;

      final topLeftPos = transform.getTranslation();
      final scale = transform.getMaxScaleOnAxis();
      final valueToScreen = (distance / barChartConstraints.barChartSize.height);

      //final topValue = maxYValue + (valueToScreen * (topLeftPos.y / scale));
      //final bottomValue = maxYValue + (valueToScreen * ((topLeftPos.y - barChartConstraints.barChartSize.height) / scale));

      // Prevents the floating point range from rendering the top/bottom values in out depending on screen size.
      const boundaryTolerance = 2.0;

      return Stack(
        clipBehavior: Clip.none,
        children: [



          for (int i = -1; i <= leftPanelValueCount; ++i)
            if ((spacing * i) + remainder <= barChartConstraints.barChartSize.height + boundaryTolerance && (spacing * i) + remainder >= -boundaryTolerance)
            Positioned(
              top: barChartConstraints.barChartOffset.dy + (spacing * i) + remainder,
              child: FractionalTranslation(
                translation: Offset(0.0, -0.5),
                child: SizedBox(
                  width: constraints.maxWidth,
                  child: Align(
                      alignment: AlignmentGeometry.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          style: GoogleFonts.googleSans(
                              fontSize: config.yValuesFontSize,
                              color: config.yValuesFontColor
                          ),
                            /*
                            style: TextStyle(
                              fontSize: config.yValuesFontSize,
                              color: config.yValuesFontColor
                            ),
                            */
                            (maxYValue + ((valueToScreen * (topLeftPos.y - ((screenUnit * i) + remainder)) / scale))).toStringAsFixed(yFloatingPointDigits)
                        ),
                      )
                  ),
                ),
              ),
            ),

          if (config.cursorTrackerEnabled && cursorYValue != null && cursorOffset != null)
            Positioned(
              top: barChartConstraints.barChartOffset.dy + cursorOffset.dy,
              child: FractionalTranslation(
                translation: Offset(0.0, -0.5),
                child: SizedBox(
                  width: constraints.maxWidth,
                  child: Align(
                      alignment: AlignmentGeometry.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                            style: GoogleFonts.googleSans(
                                fontSize: config.yValuesFontSize,
                                color: config.yValuesFontColor
                            ),
                            cursorYValue.toStringAsFixed(yFloatingPointDigits)
                        ),
                      )
                  ),
                ),
              ),),





        ],
      );
    });
  }
}
