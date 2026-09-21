import 'package:barchart/Testing/Widgets/menupicker.dart';
import 'package:barchart/Testing/Widgets/overlay.dart';
import 'package:barchart/Testing/Widgets/toppanel.dart';
import 'package:barchart/Testing/Widgets/xpanel.dart';
import 'package:barchart/Testing/Widgets/ylabel.dart';
import 'package:barchart/Testing/Widgets/ypanel.dart';
import 'package:barchart/Testing/Widgets/zeroline.dart';
import 'package:barchart/Testing/bars.dart';
import 'package:barchart/Testing/config.dart';
import 'package:barchart/Testing/transformation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:barchart/Testing/Widgets/barchart.dart';
import 'package:barchart/Testing/Widgets/ygrid.dart';
import 'package:barchart/Testing/Widgets/xgrid.dart';
import 'package:barchart/Testing/Widgets/cursortracker.dart';
import 'package:barchart/Testing/Widgets/xlabel.dart';


// For tracking the window size, panel constraints, and resizer constraints.
class BarChartConstraints{
  final double _windowWidth;
  final double _windowHeight;

  final Size _leftPanelUnitSize;
  final Size _topPanelUnitSize;
  final Size _barChartUnitSize;
  final Size _bottomPanelUnitSize;

  final Size leftPanelSize;
  final Size topPanelSize;
  final Size barChartSize;
  final Size bottomPanelSize;

  final Offset leftPanelOffset;
  final Offset topPanelOffset;
  final Offset barChartOffset;
  final Offset bottomPanelOffset;

  final double resizerWidth;

  final Size leftResizerSize;
  final Size topResizerSize;
  final Size bottomResizerSize;

  final Offset leftResizerOffset;
  final Offset topResizerOffset;
  final Offset bottomResizerOffset;

  static Size _getFullSizeFromUnitSize({required double windowWidth, required double windowHeight, required Size unitSize}){

    final width = (windowWidth > 0) ? unitSize.width * windowWidth : 0.0;
    final height = (windowHeight > 0) ? unitSize.height * windowHeight : 0.0;
    return Size(width, height);

  }
  static Offset _getLeftPanelOffset(){
    return Offset(0, 0);
  }
  static Offset _getTopPanelOffset({required Size leftPanelSize}){
    return Offset(leftPanelSize.width, 0);
  }
  static Offset _getBarChartOffset({required Size leftPanelSize, required Size topPanelSize}){
    return Offset(leftPanelSize.width, topPanelSize.height);
  }
  static Offset _getBottomPanelOffset({required Size leftPanelSize, required Size topPanelSize, required Size barChartSize}){
    return Offset(leftPanelSize.width, topPanelSize.height + barChartSize.height);
  }

  const BarChartConstraints._internal({
    required this.leftPanelSize,
    required this.topPanelSize,
    required this.barChartSize,
    required this.bottomPanelSize,
    required this.leftPanelOffset,
    required this.topPanelOffset,
    required this.barChartOffset,
    required this.bottomPanelOffset,
    required this.leftResizerSize,
    required this.topResizerSize,
    required this.bottomResizerSize,
    required this.topResizerOffset,
    required this.bottomResizerOffset,
    required this.leftResizerOffset,
    required this.resizerWidth,
    required double windowWidth,
    required double windowHeight,
    required Size leftPanelUnitSize,
    required Size topPanelUnitSize,
    required Size barChartUnitSize,
    required Size bottomPanelUnitSize,
  })
      : _windowWidth = windowWidth,
       _windowHeight = windowHeight,
       _leftPanelUnitSize = leftPanelUnitSize,
       _topPanelUnitSize = topPanelUnitSize,
       _barChartUnitSize = barChartUnitSize,
       _bottomPanelUnitSize = bottomPanelUnitSize;

  factory BarChartConstraints.fromUnitSize({
    required double windowWidth,
    required double windowHeight,
    required Size leftPanelUnitSize,
    required Size topPanelUnitSize,
    required Size barChartUnitSize,
    required Size bottomPanelUnitSize,
    required double resizerWidth,
    //required double barXSpacing
  })
  {

    final leftPanelSize = _getFullSizeFromUnitSize(windowWidth: windowWidth, windowHeight: windowHeight, unitSize: leftPanelUnitSize);
    final topPanelSize = _getFullSizeFromUnitSize(windowWidth: windowWidth, windowHeight: windowHeight, unitSize: topPanelUnitSize);
    final barChartSize = _getFullSizeFromUnitSize(windowWidth: windowWidth, windowHeight: windowHeight, unitSize: barChartUnitSize);
    final bottomPanelSize = _getFullSizeFromUnitSize(windowWidth: windowWidth, windowHeight: windowHeight, unitSize: bottomPanelUnitSize);

    final leftPanelOffset = _getLeftPanelOffset();
    final topPanelOffset = _getTopPanelOffset(leftPanelSize: leftPanelSize);
    final barChartOffset = _getBarChartOffset(leftPanelSize: leftPanelSize, topPanelSize: topPanelSize);
    final bottomPanelOffset = _getBottomPanelOffset(leftPanelSize: leftPanelSize, topPanelSize: topPanelSize, barChartSize: barChartSize);

    final leftResizerSize = Size(resizerWidth, windowHeight);
    final topResizerSize = Size(topPanelSize.width, resizerWidth);
    final bottomResizerSize = Size(bottomPanelSize.width, resizerWidth);

    final leftResizerOffset = Offset(topPanelOffset.dx - (resizerWidth * 0.5), 0);
    final topResizerOffset = Offset(barChartOffset.dx, barChartOffset.dy - (resizerWidth * 0.5));
    final bottomResizerOffset = Offset(bottomPanelOffset.dx, bottomPanelOffset.dy - (resizerWidth * 0.5));

    return BarChartConstraints._internal(
        leftPanelSize: leftPanelSize,
        topPanelSize: topPanelSize,
        barChartSize: barChartSize,
        bottomPanelSize: bottomPanelSize,
        leftPanelOffset: leftPanelOffset,
        topPanelOffset: topPanelOffset,
        barChartOffset: barChartOffset,
        bottomPanelOffset: bottomPanelOffset,
        windowWidth: windowWidth,
        windowHeight: windowHeight,
        leftPanelUnitSize: leftPanelUnitSize,
        topPanelUnitSize: topPanelUnitSize,
        barChartUnitSize: barChartUnitSize,
        bottomPanelUnitSize: bottomPanelUnitSize,
        leftResizerSize: leftResizerSize,
        topResizerSize: topResizerSize,
        bottomResizerSize: bottomResizerSize,
        leftResizerOffset: leftResizerOffset,
        topResizerOffset: topResizerOffset,
        bottomResizerOffset: bottomResizerOffset,
        resizerWidth: resizerWidth,
        //barXSpacing: barXSpacing
    );

  }

  BarChartConstraints copyWithWidthAndHeight({double? windowWidth, double? windowHeight}){

    final width = windowWidth ?? _windowWidth;
    final height = windowHeight ?? _windowHeight;

    return BarChartConstraints.fromUnitSize(
        windowWidth: width,
        windowHeight: height,
        leftPanelUnitSize: _leftPanelUnitSize,
        topPanelUnitSize: _topPanelUnitSize,
        barChartUnitSize: _barChartUnitSize,
        bottomPanelUnitSize: _bottomPanelUnitSize,
        resizerWidth: resizerWidth,
        //barXSpacing: barXSpacing
    );

  }
  BarChartConstraints copyWithResizerWidth({required double resizerWidth}){
    return BarChartConstraints.fromUnitSize(
        windowWidth: _windowWidth,
        windowHeight: _windowHeight,
        leftPanelUnitSize: _leftPanelUnitSize,
        topPanelUnitSize: _topPanelUnitSize,
        barChartUnitSize: _barChartUnitSize,
        bottomPanelUnitSize: _bottomPanelUnitSize,
        resizerWidth: resizerWidth,
        //barXSpacing: barXSpacing
    );
  }


  BarChartConstraints copyWithTransformedLeftPanel({required double deltaX}){

    final unit = (_windowWidth > 0) ? deltaX / _windowWidth : 0.0;

    final leftPanelUnitSize = Size((_leftPanelUnitSize.width + unit).clamp(0, 1.0), _leftPanelUnitSize.height);
    final rightPanelUnitX = Size(1.0 - leftPanelUnitSize.width, 1.0);

    final topPanelUnitSize = Size(rightPanelUnitX.width, _topPanelUnitSize.height);
    final barChartUnitSize = Size(rightPanelUnitX.width, _barChartUnitSize.height);
    final bottomPanelUnitSize = Size(rightPanelUnitX.width, _bottomPanelUnitSize.height);

    return BarChartConstraints.fromUnitSize(
        windowWidth: _windowWidth,
        windowHeight: _windowHeight,
        leftPanelUnitSize: leftPanelUnitSize,
        topPanelUnitSize: topPanelUnitSize,
        barChartUnitSize: barChartUnitSize,
        bottomPanelUnitSize: bottomPanelUnitSize,
        resizerWidth: resizerWidth,
        //barXSpacing: barXSpacing
    );

  }
  BarChartConstraints copyWithTransformedTopPanel({required double deltaY}){

    final unit = (_windowHeight > 0) ? deltaY / _windowHeight : 0.0;

    final topPanelUnitSize = Size(_topPanelUnitSize.width, (_topPanelUnitSize.height + unit).clamp(0.0, 1.0 - _bottomPanelUnitSize.height));
    final barChartUnitSize = Size(_barChartUnitSize.width, 1.0 - (topPanelUnitSize.height + _bottomPanelUnitSize.height));

    return BarChartConstraints.fromUnitSize(
        windowWidth: _windowWidth,
        windowHeight: _windowHeight,
        leftPanelUnitSize: _leftPanelUnitSize,
        topPanelUnitSize: topPanelUnitSize,
        barChartUnitSize: barChartUnitSize,
        bottomPanelUnitSize: _bottomPanelUnitSize,
        resizerWidth: resizerWidth,
        //barXSpacing: barXSpacing
    );

  }
  BarChartConstraints copyWithTransformedBottomPanel({required double deltaY}){

    final unit = (_windowHeight > 0) ? deltaY / _windowHeight : 0.0;

    final bottomPanelUnitSize = Size(_bottomPanelUnitSize.width, (_bottomPanelUnitSize.height + unit).clamp(0.0, 1.0 - _topPanelUnitSize.height));
    final barChartUnitSize = Size(_barChartUnitSize.width, 1.0 - (bottomPanelUnitSize.height + _topPanelUnitSize.height));

    return BarChartConstraints.fromUnitSize(
        windowWidth: _windowWidth,
        windowHeight: _windowHeight,
        leftPanelUnitSize: _leftPanelUnitSize,
        topPanelUnitSize: _topPanelUnitSize,
        barChartUnitSize: barChartUnitSize,
        bottomPanelUnitSize: bottomPanelUnitSize,
        resizerWidth: resizerWidth,
        //barXSpacing: barXSpacing
    );

  }
}

class BarChartConstraintsNotifier extends Notifier<BarChartConstraints>{

  BarChartConstraintsNotifier({
    required this.initialConstraints,
  });
  BarChartConstraints initialConstraints;

  @override
  BarChartConstraints build() => initialConstraints;

  void set({required BarChartConstraints constraints}){
    state = constraints;
  }

}

class BarChartGlobalConstraints{
  static bool _initialised = false;
  static bool get isInitialised => _initialised;

  static void initialise({required BarChartConstraints barChartConstraints}){
    if (!_initialised){
      constraints = NotifierProvider<BarChartConstraintsNotifier, BarChartConstraints>(() => BarChartConstraintsNotifier(initialConstraints: barChartConstraints));
      zeroLineYOffset = Provider<double?>((ref) {

        final constraints = ref.watch(BarChartGlobalConstraints.constraints);
        final transform = ref.watch(BarChartGlobalTransformation.transformation);
        final yDistance = ref.watch(BarChartGlobalBars.yDistance);
        final maxY = ref.watch(BarChartGlobalBars.maxYValue);
        final scale = transform.getMaxScaleOnAxis();

        final unit = constraints.barChartSize.height / yDistance;
        final centerY = (maxY * unit * scale) + transform.getTranslation().y;

        return centerY;

      });
      _initialised = true;
    }
  }

  static late NotifierProvider<BarChartConstraintsNotifier, BarChartConstraints> constraints;
  static late Provider<double?> zeroLineYOffset;
}


class BarChartExample extends HookConsumerWidget {
  const BarChartExample({super.key});

  // updates the global bar chart constraints width and height fields when the layout builder rebuilds.
  void updateConstraintsWidthAndHeight({required WidgetRef ref, required BoxConstraints constraints}){
    WidgetsBinding.instance.addPostFrameCallback((_){
      final barChartConstraints = ref.read(BarChartGlobalConstraints.constraints);
      ref.read(BarChartGlobalConstraints.constraints.notifier).set(constraints: barChartConstraints.copyWithWidthAndHeight(windowWidth: constraints.maxWidth, windowHeight: constraints.maxHeight));
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return LayoutBuilder(builder: (context, constraints) {

      updateConstraintsWidthAndHeight(ref: ref, constraints: constraints);

      return Stack(children: [

        const _TopPanelBackground(),
        const _LeftPanelBackground(),
        const _BarChartBackground(),
        const _BottomPanelBackground(),

        const _YGrid(),

        const _XGrid(),

        const ZeroLine(),

        const _LeftPanel(),

        const _TopPanel(),

        const _BottomPanel(),

        const _CursorTracker(),

        const _BarChartPanel(),

        const _LeftResizer(),

        const _TopResizer(),

        const _BottomResizer(),

        const _BarOverlay(),

        const XLabel(),

        const YLabel(),

        const _MenuPicker(),



      ]);

    });

  }
}

class _BarOverlay extends HookConsumerWidget{

  const _BarOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final constraints = ref.watch(BarChartGlobalConstraints.constraints);

    return Positioned(
        top: constraints.barChartOffset.dy,
        left: constraints.barChartOffset.dx,
        child: SizedBox(
          width: constraints.barChartSize.width,
          height: constraints.barChartSize.height,
          child: BarOverlay(),
        )
    );
  }



}

class _CursorTracker extends HookConsumerWidget{

  const _CursorTracker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final constraints = ref.watch(BarChartGlobalConstraints.constraints);

    return Positioned(
      left: constraints.barChartOffset.dx,
      top: constraints.barChartOffset.dy,
      child: SizedBox(
        width: constraints.barChartSize.width,
        height: constraints.barChartSize.height,
        child: CursorTracker(),
      ),
    );
  }



}

class _MenuPicker extends HookConsumerWidget{

  const _MenuPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final constraints = ref.watch(BarChartGlobalConstraints.constraints);

    return Positioned(
        top: 0,
        left: 0,
        child: SizedBox(
            width: constraints._windowWidth,
            height: constraints._windowHeight,
            child: MenuPicker()
        )
    );
  }

}

class _BottomResizer extends HookConsumerWidget {
  const _BottomResizer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final barChartConstraints = ref.watch(BarChartGlobalConstraints.constraints);
    final config = ref.watch(BarChartGlobalConfig.configNotifier);

    return Positioned(
        left: barChartConstraints.bottomResizerOffset.dx,
        top: barChartConstraints.bottomResizerOffset.dy,
        child: MouseRegion(
          cursor: SystemMouseCursors.resizeRow,
          child: GestureDetector(
            onVerticalDragUpdate: (drag){
              ref.read(BarChartGlobalConstraints.constraints.notifier).set(constraints: ref.read(BarChartGlobalConstraints.constraints).copyWithTransformedBottomPanel(deltaY: -drag.delta.dy));
            },
            child: SizedBox(
                width: barChartConstraints.bottomResizerSize.width,
                height: barChartConstraints.bottomResizerSize.height,
                child: ColoredBox(
                    color: (config.showResizerLines) ? Colors.black : Colors.transparent
                )
            ),
          ),
        )
    );
  }
}

class _TopResizer extends HookConsumerWidget {
  const _TopResizer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final barChartConstraints = ref.watch(BarChartGlobalConstraints.constraints);
    final config = ref.watch(BarChartGlobalConfig.configNotifier);

    return Positioned(
        left: barChartConstraints.topResizerOffset.dx,
        top: barChartConstraints.topResizerOffset.dy,
        child: MouseRegion(
          cursor: SystemMouseCursors.resizeRow,
          child: GestureDetector(
            onVerticalDragUpdate: (drag){
              ref.read(BarChartGlobalConstraints.constraints.notifier).set(constraints: ref.read(BarChartGlobalConstraints.constraints).copyWithTransformedTopPanel(deltaY: drag.delta.dy));
            },
            child: SizedBox(
              width: barChartConstraints.topResizerSize.width,
              height: barChartConstraints.topResizerSize.height,
                child: ColoredBox(
                    color: (config.showResizerLines) ? Colors.black : Colors.transparent
                )
            ),
          ),
        )
    );
  }
}

class _LeftResizer extends HookConsumerWidget {
  const _LeftResizer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final barChartConstraints = ref.watch(BarChartGlobalConstraints.constraints);
    final config = ref.watch(BarChartGlobalConfig.configNotifier);

    return Positioned(
        left: barChartConstraints.leftResizerOffset.dx,
        top: barChartConstraints.leftResizerOffset.dy,
        child: MouseRegion(
          cursor: SystemMouseCursors.resizeColumn,
          child: GestureDetector(
            onHorizontalDragUpdate: (drag){
              ref.read(BarChartGlobalConstraints.constraints.notifier).set(constraints: ref.read(BarChartGlobalConstraints.constraints).copyWithTransformedLeftPanel(deltaX: drag.delta.dx));
            },
            child: SizedBox(
                width: barChartConstraints.leftResizerSize.width,
                height: barChartConstraints.leftResizerSize.height,
                child: ColoredBox(
                    color: (config.showResizerLines) ? Colors.black : Colors.transparent
                )
            ),
          ),
        )
    );
  }
}

class _BottomPanel extends HookConsumerWidget {
  const _BottomPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final barChartConstraints = ref.watch(BarChartGlobalConstraints.constraints);

    return Positioned(
      left: barChartConstraints.bottomPanelOffset.dx,
      top: barChartConstraints.bottomPanelOffset.dy,
      child: SizedBox(
        width: barChartConstraints.bottomPanelSize.width,
        height: barChartConstraints.bottomPanelSize.height,
        child: XPanel(),
      ),
    );
  }
}

class _BarChartPanel extends HookConsumerWidget {
  const _BarChartPanel({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final barChartConstraints = ref.watch(BarChartGlobalConstraints.constraints);

    return Positioned(
      left: barChartConstraints.barChartOffset.dx,
      top: barChartConstraints.barChartOffset.dy,
      child: SizedBox(
        width: barChartConstraints.barChartSize.width,
        height: barChartConstraints.barChartSize.height,
        child: BarChart(),
      ),
    );
  }
}

class _TopPanel extends HookConsumerWidget {
  const _TopPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final barChartConstraints = ref.watch(BarChartGlobalConstraints.constraints);

    return Positioned(
      //left: barChartConstraints.topPanelOffset.dx,
      left: 0,
      top: barChartConstraints.topPanelOffset.dy,
      child: SizedBox(
        width: barChartConstraints.topPanelSize.width + barChartConstraints.leftPanelSize.width,
        height: barChartConstraints.topPanelSize.height,
        child: TopPanel(),
      ),
    );
  }
}

class _LeftPanel extends HookConsumerWidget {
  const _LeftPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final barChartConstraints = ref.watch(BarChartGlobalConstraints.constraints);
    final config = ref.watch(BarChartGlobalConfig.configNotifier);

    return Positioned(
      left: barChartConstraints.leftPanelOffset.dx,
      top: barChartConstraints.leftPanelOffset.dy,
      child: SizedBox(
        width: barChartConstraints.leftPanelSize.width,
        height: barChartConstraints.leftPanelSize.height,
        //child: YPanel(),
        child: (config.staticYGrid)
            ? YPanel()
            : YPanelUpdated(),
      ),
    );
  }
}

class _YGrid extends HookConsumerWidget {
  const _YGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final barChartConstraints = ref.watch(BarChartGlobalConstraints.constraints);

    return Positioned(
      left: barChartConstraints.topPanelOffset.dx,
      top: barChartConstraints.topPanelOffset.dy,
      child: SizedBox(
        width: barChartConstraints.topPanelSize.width,
        height: barChartConstraints.topPanelSize.height,
        child: YGrid(),
      ),
    );
  }
}

class _XGrid extends HookConsumerWidget {
  const _XGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final barChartConstraints = ref.watch(BarChartGlobalConstraints.constraints);

    return Positioned(
      left: barChartConstraints.topPanelOffset.dx,
      top: barChartConstraints.topPanelOffset.dy,
      child: SizedBox(
        width: barChartConstraints.topPanelSize.width,
        height: barChartConstraints.topPanelSize.height,
        child: XGrid(),
      ),
    );
  }
}

class _TopPanelBackground extends HookConsumerWidget{

  const _TopPanelBackground({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final config = ref.watch(BarChartGlobalConfig.configNotifier);
    final constraints = ref.watch(BarChartGlobalConstraints.constraints);

    return Positioned(
        top: 0,
        left: constraints.topPanelOffset.dx,
        child: SizedBox(
          width: constraints.topPanelSize.width,
          height: constraints.topPanelSize.height,
          child: ColoredBox(color: config.topPanelBackgroundColor),
        )
    );

  }
}

class _LeftPanelBackground extends HookConsumerWidget{

  const _LeftPanelBackground({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final config = ref.watch(BarChartGlobalConfig.configNotifier);
    final constraints = ref.watch(BarChartGlobalConstraints.constraints);

    return Positioned(
        top: 0,
        left: 0,
        child: SizedBox(
          width: constraints.leftPanelSize.width,
          height: constraints.leftPanelSize.height,
          child: ColoredBox(color: config.leftPanelBackgroundColor),
        )
    );

  }
}

class _BarChartBackground extends HookConsumerWidget{

  const _BarChartBackground({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final config = ref.watch(BarChartGlobalConfig.configNotifier);
    final constraints = ref.watch(BarChartGlobalConstraints.constraints);

    return Positioned(
        top: constraints.barChartOffset.dy,
        left: constraints.barChartOffset.dx,
        child: SizedBox(
          width: constraints.barChartSize.width,
          height: constraints.barChartSize.height,
          child: ColoredBox(color: config.barChartBackgroundColor),
        )
    );

  }
}

class _BottomPanelBackground extends HookConsumerWidget{

  const _BottomPanelBackground({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final config = ref.watch(BarChartGlobalConfig.configNotifier);
    final constraints = ref.watch(BarChartGlobalConstraints.constraints);

    return Positioned(
        top: constraints.bottomPanelOffset.dy,
        left: constraints.bottomPanelOffset.dx,
        child: SizedBox(
          width: constraints.bottomPanelSize.width,
          height: constraints.bottomPanelSize.height,
          child: ColoredBox(color: config.bottomPanelBackgroundColor),
        )
    );

  }
}


