import 'package:barchart/Testing/config.dart';
import 'package:barchart/Testing/constraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:barchart/Testing/bars.dart';
import 'package:barchart/Testing/transformation.dart';

class ZeroLinePainter extends CustomPainter{

  const ZeroLinePainter({
    required this.width,
    this.zeroLineYOffset
  });

  final double width;
  final double? zeroLineYOffset;

  @override
  void paint(Canvas canvas, Size size) {

    if (zeroLineYOffset != null){

      if (zeroLineYOffset!.isNaN){
        return;
      }

      canvas.drawLine(
          Offset(0, zeroLineYOffset!),
          Offset(width, zeroLineYOffset!),
          Paint()..color = Colors.black..strokeWidth = 1
      );
    }

  }

  @override
  bool shouldRepaint(covariant ZeroLinePainter oldDelegate) {
    return
        zeroLineYOffset != oldDelegate.zeroLineYOffset ||
        width != oldDelegate.width;
  }


}

class ZeroLine extends HookConsumerWidget {
  const ZeroLine({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final config = ref.watch(BarChartGlobalConfig.configNotifier);
    final constraints = ref.watch(BarChartGlobalConstraints.constraints);
    final zeroLineYOffset = ref.watch(BarChartGlobalConstraints.zeroLineYOffset);

    if (!config.showZeroLine || zeroLineYOffset == null){
      return Positioned(top: 0, left: 0, child: SizedBox.shrink());
    }

    if (zeroLineYOffset < 0 || zeroLineYOffset > constraints.barChartSize.height){
      return Positioned(top: 0, left: 0, child: SizedBox.shrink());
    }

    return Positioned(
      top: constraints.barChartOffset.dy,
      left: constraints.barChartOffset.dx,
      child: CustomPaint(painter: ZeroLinePainter(
          width: constraints.barChartSize.width,
          zeroLineYOffset: zeroLineYOffset
        )
      ),
    );
  }
}
