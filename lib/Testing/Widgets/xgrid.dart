import 'package:barchart/Testing/config.dart';
import 'package:barchart/Testing/constraints.dart';
import 'package:barchart/Testing/transformation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:barchart/Testing/Widgets/menupicker.dart';

class XGridPainter extends CustomPainter{

  const XGridPainter({
    required this.constraints,
    required this.config,
    required this.transform,
    required this.opacity
  });

  final Matrix4 transform;
  final BarChartConstraints constraints;
  final BarChartConfig config;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {

    final offset = transform.getTranslation().x;
    final scale = transform.getMaxScaleOnAxis();

    final scaledBarWidth = config.barWidth * scale;
    final scaleBarXSpacing = config.barXSpacing * scale;
    final scaledTotalX = scaledBarWidth + scaleBarXSpacing;
    final barCenter = scaledBarWidth / 2;

    final x = ((offset % (scaledTotalX)) - scaledTotalX + barCenter);
    final y = constraints.barChartOffset.dy;

    canvas.drawLine(
        Offset(0, y),
        Offset(0, y + constraints.barChartSize.height),
        Paint()..color = Colors.black.withValues(alpha: opacity)..strokeWidth = 1
    );

    for (double i = x; i < constraints.barChartSize.width; i += scaledTotalX){

      if (i < 0){
        continue;
      }

      canvas.drawLine(
          Offset(i, y),
          Offset(i, y + constraints.barChartSize.height),
          Paint()..color = Colors.black.withValues(alpha: opacity)..strokeWidth = 1
      );
    }
  }

  @override
  bool shouldRepaint(covariant XGridPainter oldDelegate) {
    return constraints != oldDelegate.constraints ||
        config != oldDelegate.config ||
        transform != oldDelegate.transform ||
        opacity != oldDelegate.opacity;
  }


}

class XGrid extends HookConsumerWidget {
  const XGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final constraints = ref.watch(BarChartGlobalConstraints.constraints);
    final config = ref.watch(BarChartGlobalConfig.configNotifier);
    final transform = ref.watch(BarChartGlobalTransformation.transformation);

    if (!config.showXGrid){
      return SizedBox.shrink();
    }

    return CustomPaint(
      painter: XGridPainter(
          opacity: config.xGridOpacity,
          constraints: constraints,
          config: config,
          transform: transform
      ),
    );
  }
}