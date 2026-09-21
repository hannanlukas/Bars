import 'package:barchart/Testing/bars.dart';
import 'package:barchart/Testing/config.dart';
import 'package:barchart/Testing/constraints.dart';
import 'package:barchart/Testing/cursor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BarOverlay extends HookConsumerWidget {
  const BarOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final config = ref.watch(BarChartGlobalConfig.configNotifier);
    final cursorOffset = ref.watch(BarChartGlobalCursor.barChartCursorOffset);
    final xIndex = ref.watch(BarChartGlobalCursor.hoveringOverXIndex);
    final yValue = ref.watch(BarChartGlobalCursor.hoveringOverYValue);
    final bars = ref.watch(BarChartGlobalBars.activeBars);

    if (config.enableBarOverlays == false || cursorOffset == null || xIndex == null || yValue == null){
      return SizedBox.shrink();
    }

    if (xIndex < 0 || xIndex >= bars.length){
      return SizedBox.shrink();
    }

    final bar = bars[xIndex];

    if (bar.yValue < 0.0){
      if (yValue > 0.0 || yValue < bar.yValue){
        return SizedBox.shrink();
      }
    }
    else{
      if (yValue < 0.0 || yValue > bar.yValue){
        return SizedBox.shrink();
      }
    }

    return IgnorePointer(
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
      
            Positioned(
              top: cursorOffset.dy,
              left: cursorOffset.dx,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 4.0, offset: Offset(4, 4))]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        bar.xLabel,
                        style: GoogleFonts.googleSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("${config.xName}: ${bar.xValue.toStringAsFixed(config.yValueFloatingPointDigits)}", style: GoogleFonts.googleSans(),),
                      Text("${config.yName}: ${bar.yValue.toStringAsFixed(config.yValueFloatingPointDigits)}", style: GoogleFonts.googleSans(),)
                    ],
                  ),
                ),
              ),
            )
      
          ],
        );
      }),
    );
  }
}
