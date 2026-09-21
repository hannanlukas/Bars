import 'package:barchart/Testing/config.dart';
import 'package:barchart/Testing/constraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:barchart/Testing/bars.dart';
import 'package:barchart/Testing/transformation.dart';
import 'package:google_fonts/google_fonts.dart';

class TopPanel extends HookConsumerWidget {
  const TopPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final config = ref.watch(BarChartGlobalConfig.configNotifier);

    if (!config.showTitle){
      return SizedBox.shrink();
    }

    return LayoutBuilder(builder: (context, constraints) {

      return Row(
        children: [
          Expanded(
              child: Center(
                  child: Text(
                      config.barChartTitle,
                      style: GoogleFonts.googleSans(
                        fontWeight: FontWeight.bold,
                        fontSize: config.titleFontSize,
                        color: config.titleFontColor
                      )
                      /*
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: config.titleFontSize,
                        color: config.titleFontColor
                      ),
                       */
                  )
              )
          )
        ],
      );
      
    });
  }
}
