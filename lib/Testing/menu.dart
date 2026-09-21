import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum BarChartMenu{
  settings,
  information,
  barModifications,
  barSorter,
  save,
  warnings
}

class BarChartMenuNotifier extends Notifier<BarChartMenu?>{

  @override
  BarChartMenu? build() => null;

  void set({required BarChartMenu? menu}){
    state = menu;
  }
}

class BarChartGlobalMenu{

  static final activeMenu = NotifierProvider<BarChartMenuNotifier, BarChartMenu?>(() => BarChartMenuNotifier());

}