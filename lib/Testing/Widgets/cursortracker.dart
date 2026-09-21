import 'package:barchart/Testing/config.dart';
import 'package:barchart/Testing/constraints.dart';
import 'package:barchart/Testing/cursor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:barchart/Testing/bars.dart';
import 'package:barchart/Testing/transformation.dart';


class CursorTrackerPainter extends CustomPainter{

  const CursorTrackerPainter({
    required this.barChartSize,
    required this.mouseOffset,
  });

  final Size barChartSize;
  final Offset mouseOffset;

  @override
  void paint(Canvas canvas, Size size) {

    canvas.drawLine(
        Offset(mouseOffset.dx, 0),
        Offset(mouseOffset.dx, barChartSize.height),
        Paint()..color = Colors.grey..strokeWidth = 1
    );

    canvas.drawLine(
        Offset(0, mouseOffset.dy),
        Offset(barChartSize.width, mouseOffset.dy),
        Paint()..color = Colors.grey..strokeWidth = 1
    );

  }

  @override
  bool shouldRepaint(covariant CursorTrackerPainter oldDelegate) {
    return barChartSize != oldDelegate.barChartSize || mouseOffset != oldDelegate.mouseOffset;
  }


}

class CursorTracker extends HookConsumerWidget {
  const CursorTracker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final constraints = ref.watch(BarChartGlobalConstraints.constraints);
    final barChartSize = constraints.barChartSize;
    final config = ref.watch(BarChartGlobalConfig.configNotifier);


    final cursorOffset = ref.watch(BarChartGlobalCursor.barChartCursorOffset);
    final x = ref.watch(BarChartGlobalCursor.hoveringOverXIndex);
    final y = ref.watch(BarChartGlobalCursor.hoveringOverYValue);


    return LayoutBuilder(builder:  (context, constraints) {
      return Stack(
        children: [
          if (cursorOffset != null && config.cursorTrackerEnabled)
            CustomPaint(
                painter: CursorTrackerPainter(
                    barChartSize: barChartSize,
                    mouseOffset: cursorOffset)
            ),

        ],
      );
    });
  }
}
