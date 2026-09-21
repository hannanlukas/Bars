import 'package:barchart/Testing/bars.dart';
import 'package:barchart/Testing/config.dart';
import 'package:barchart/Testing/constraints.dart';
import 'package:barchart/Testing/cursor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class XLabel extends HookConsumerWidget {
  const XLabel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final config = ref.watch(BarChartGlobalConfig.configNotifier);
    final constraints = ref.watch(BarChartGlobalConstraints.constraints);

    if (!config.showXLabel){
      return Positioned(top: 0, left: 0, child: SizedBox.shrink());
    }

    return Positioned(
        bottom: 0,
        left: constraints.leftPanelSize.width + (constraints.barChartSize.width / 2),
        child: FractionalTranslation(
            translation: Offset(-0.5, 0),
            child: Container(
                color: config.bottomPanelBackgroundColor,
                child: Text(
                    config.showLabelsInBottomPanel ? config.xValueLabelForNames : config.xValueLabelForValues,
                    style: GoogleFonts.googleSans(
                      fontSize: config.xLabelFontSize,
                      color: config.xLabelFontColor,
                      fontWeight: FontWeight.w400
                    ),
                    /*
                    style: TextStyle(
                      fontSize: config.xLabelFontSize,
                      color: config.xLabelFontColor
                    ),

                     */
                )
            )
        )
    );
  }
}
