import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BarChartTransformationNotifier extends Notifier<Matrix4>{

  BarChartTransformationNotifier({required this.initialTransformation,});
  final Matrix4 initialTransformation;

  @override
  Matrix4 build() => initialTransformation;

  void set({required Matrix4 transformation}){
    state = transformation;
  }
}

class BarChartGlobalTransformation{
  static bool _initialised = false;
  static bool get isInitialised => _initialised;

  static void initialise({required Matrix4 transformation}){
    if (_initialised){
      return;
    }

    BarChartGlobalTransformation.transformation = NotifierProvider<BarChartTransformationNotifier, Matrix4>(() => BarChartTransformationNotifier(initialTransformation: transformation));
    _initialised = true;
  }

  static late final NotifierProvider<BarChartTransformationNotifier, Matrix4> transformation;

}
