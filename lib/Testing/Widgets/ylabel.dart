import 'package:barchart/Testing/bars.dart';
import 'package:barchart/Testing/config.dart';
import 'package:barchart/Testing/constraints.dart';
import 'package:barchart/Testing/cursor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class YLabel extends HookConsumerWidget {
  const YLabel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final config = ref.watch(BarChartGlobalConfig.configNotifier);
    final constraints = ref.watch(BarChartGlobalConstraints.constraints);

    if (!config.showYLabel){
      return Positioned(top: 0, left: 0, child: SizedBox.shrink());
    }

    return Positioned(
        top: constraints.topPanelSize.height + (constraints.barChartSize.height / 2),
        left: 0,
        child: FractionalTranslation(
            translation: Offset(0, -0.5),
            child: RotatedBox(
                quarterTurns: -1,
                child: Container(
                    color: config.leftPanelBackgroundColor,
                    child: Text(
                        config.yValueLabel,
                        style: GoogleFonts.googleSans(
                            fontSize: config.yLabelFontSize,
                            color: config.yLabelFontColor,
                            fontWeight: FontWeight.w400
                        ),
                        /*
                        style: TextStyle(
                          fontSize: config.yLabelFontSize,
                          color: config.yLabelFontColor
                        ),

                         */
                    )
                )
            )
        )
    );
  }
}