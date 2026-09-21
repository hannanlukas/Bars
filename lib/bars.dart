import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:hooks_riverpod/hooks_riverpod.dart';

class Bar{
  const Bar({
    required this.xValue,
    required this.yValue,
    this.color = Colors.green,
    this.xLabel = "",
    required this.insertionIndex
  });

  factory Bar.randomColor({required double xValue, required double yValue, String xLabel = "", required int insertionIndex}){
    return Bar(
        xValue: xValue,
        yValue: yValue,
        xLabel: xLabel,
        color: Color.fromARGB(
            255,
            math.Random().nextInt(256),
            math.Random().nextInt(256),
            math.Random().nextInt(256)
        ),
        insertionIndex: insertionIndex
    );
  }

  final double xValue;
  final double yValue;
  final Color color;
  final String xLabel;
  final int insertionIndex;
}

class ActiveBars{

  ActiveBars._privateConstructor({
    required List<Bar> bars,
    required Set<Bar> activeBarSet,
    required Set<Bar> inactiveBarSet,
    required List<Bar> activeBars,
    required List<Bar> inactiveBars
  })
      : _bars = bars,
        _activeBars = activeBars,
        _inactiveBars = inactiveBars,
        _activeBarSet = activeBarSet,
        _inactiveBarSet = inactiveBarSet;


  factory ActiveBars.initialisation({required List<Bar> bars}){
    return ActiveBars._privateConstructor(
        bars: bars.toList(),
        activeBars: bars.toList(),
        activeBarSet: bars.toSet(),
        inactiveBars: [],
        inactiveBarSet: {}
    );
  }

  // bars is unchanging so it will remain the same throughout.
  final List<Bar> _bars;

  // sets are used only to check while bar belongs in which state.
  final Set<Bar> _activeBarSet;
  final Set<Bar> _inactiveBarSet;

  // active/inactive bars should primarily be checked via lists.
  final List<Bar> _activeBars;
  final List<Bar> _inactiveBars;

  // Checks if an existing bar is active or inactive
  bool isActive({required Bar bar}){
    if (_activeBarSet.contains(bar)){
      return true;
    }
    return false;
  }


  // returns all the bars
  List<Bar> get all => _bars;
  // returns the active bars
  List<Bar> get active => _activeBars;
  // returns the inactive bars
  List<Bar> get inactive => _inactiveBars;
}

class GlobalActiveBars extends Notifier<ActiveBars>{

  GlobalActiveBars({
    required this.initialBars,
  });
  final List<Bar> initialBars;

  @override
  ActiveBars build() => ActiveBars.initialisation(bars: initialBars);

  void set({required int barIndex, required bool value}){

    if (barIndex < 0 || barIndex >= state._bars.length){
      return;
    }

    final bar = state._bars[barIndex];
    if (value){
      if (state._activeBarSet.contains(bar)){
        return;
      }
      state._activeBarSet.add(bar);
      state._inactiveBarSet.remove(bar);
    }
    else{
      if (state._inactiveBarSet.contains(bar)){
        return;
      }
      state._inactiveBarSet.add(bar);
      state._activeBarSet.remove(bar);
    }

    final List<Bar> activeBars = [];
    final List<Bar> inactiveBars = [];

    for (final b in state._bars){
      if (state.isActive(bar: b)){
        activeBars.add(b);
      }
      else{
        inactiveBars.add(b);
      }
    }

    state = ActiveBars._privateConstructor(
        bars: state._bars,
        activeBarSet: state._activeBarSet,
        inactiveBarSet: state._inactiveBarSet,
        activeBars: activeBars,
        inactiveBars: inactiveBars
    );

  }

  void setBarColor({required int barIndex, required Color color}){

    if (barIndex < 0 || barIndex >= initialBars.length){
      return;
    }

    final selectedBar = state._bars[barIndex];
    final updatedBar = Bar(xValue: selectedBar.xValue, yValue: selectedBar.yValue, xLabel: selectedBar.xLabel, color: color, insertionIndex: selectedBar.insertionIndex);

    if (state._activeBarSet.contains(selectedBar)){
      state._activeBarSet.remove(selectedBar);
      state._activeBarSet.add(updatedBar);
    }
    if (state._inactiveBarSet.contains(selectedBar)){
      state._inactiveBarSet.remove(selectedBar);
      state._inactiveBarSet.add(updatedBar);
    }

    state._bars[barIndex] = updatedBar;

    final bars = state._bars.toList();
    final List<Bar> activeBars = [];
    final List<Bar> inactiveBars = [];

    for (final b in bars){
      if (state._activeBarSet.contains(b)){
        activeBars.add(b);
      }
      else{
        inactiveBars.add(b);
      }
    }

    state = ActiveBars._privateConstructor(
        bars: bars,
        activeBarSet: state._activeBarSet,
        inactiveBarSet: state._inactiveBarSet,
        activeBars: activeBars,
        inactiveBars: inactiveBars
    );
  }

  // resets to the default initial bars
  void reset(){
    state = ActiveBars.initialisation(bars: initialBars);
  }

  void sortInsertionOrder(){

    final sortedBars = state._bars.toList()..sort((a, b){
      if (a.insertionIndex < b.insertionIndex){
        return -1;
      }
      if (a.insertionIndex > b.insertionIndex){
        return 1;
      }
      return 0;
    });
    final List<int> inactiveBars = [];

    for (final (index, bar) in sortedBars.indexed){
      if (!state.isActive(bar: bar)){
        inactiveBars.add(index);
      }
    }

    state = ActiveBars.initialisation(bars: sortedBars);
    for (final b in inactiveBars){
      set(barIndex: b, value: false);
    }
  }

  void sortLowestXToHighestX(){

    final sortedBars = state._bars.toList()..sort((a, b){
      if (a.xValue < b.xValue){
        return -1;
      }
      if (a.xValue > b.xValue){
        return 1;
      }
      return 0;
    });
    final List<int> inactiveBars = [];

    for (final (index, bar) in sortedBars.indexed){
      if (!state.isActive(bar: bar)){
        inactiveBars.add(index);
      }
    }

    state = ActiveBars.initialisation(bars: sortedBars);
    for (final b in inactiveBars){
      set(barIndex: b, value: false);
    }
  }
  void sortHighestXToLowestX(){
    final sortedBars = state._bars.toList()..sort((a, b){
      if (a.xValue < b.xValue){
        return 1;
      }
      if (a.xValue > b.xValue){
        return -1;
      }
      return 0;
    });
    final List<int> inactiveBars = [];

    for (final (index, bar) in sortedBars.indexed){
      if (!state.isActive(bar: bar)){
        inactiveBars.add(index);
      }
    }

    state = ActiveBars.initialisation(bars: sortedBars);
    for (final b in inactiveBars){
      set(barIndex: b, value: false);
    }
  }
  void sortLowestToHighestY(){
    final sortedBars = state._bars.toList()..sort((a, b){
      if (a.yValue < b.yValue){
        return -1;
      }
      if (a.yValue > b.yValue){
        return 1;
      }
      return 0;
    });
    final List<int> inactiveBars = [];

    for (final (index, bar) in sortedBars.indexed){
      if (!state.isActive(bar: bar)){
        inactiveBars.add(index);
      }
    }

    state = ActiveBars.initialisation(bars: sortedBars);
    for (final b in inactiveBars){
      set(barIndex: b, value: false);
    }
  }
  void sortHighestToLowestY(){
    final sortedBars = state._bars.toList()..sort((a, b){
      if (a.yValue < b.yValue){
        return 1;
      }
      if (a.yValue > b.yValue){
        return -1;
      }
      return 0;
    });
    final List<int> inactiveBars = [];

    for (final (index, bar) in sortedBars.indexed){
      if (!state.isActive(bar: bar)){
        inactiveBars.add(index);
      }
    }

    state = ActiveBars.initialisation(bars: sortedBars);
    for (final b in inactiveBars){
      set(barIndex: b, value: false);
    }
  }


}