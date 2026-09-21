import 'dart:convert';

import 'package:barchart/Testing/bars.dart';
import 'package:barchart/Testing/config.dart';
import 'package:barchart/Testing/constraints.dart';
import 'package:barchart/Testing/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:barchart/Testing/Widgets/menupicker.dart';
import 'package:file_picker/file_picker.dart';

class SaveMenu extends HookConsumerWidget {
  const SaveMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final activeMenu = ref.watch(BarChartGlobalMenu.activeMenu);
    final config = ref.watch(BarChartGlobalConfig.configNotifier);
    final constraints = ref.watch(BarChartGlobalConstraints.constraints);
    final bars = ref.watch(BarChartGlobalBars.bars);

    String constructSavable(){

      Map<String, dynamic> colorToMap({required Color color}){
        return {
          "r" : (color.r * 255).toInt(),
          "g" : (color.g * 255).toInt(),
          "b" : (color.b * 255).toInt(),
          "a" : (color.a * 255).toInt(),
        };
      }

      final settingsMap = {
        "title" : config.barChartTitle,
        "xLabelForValues" : config.xValueLabelForValues,
        "xLabelForNames" : config.xValueLabelForNames,
        "yLabel": config.yValueLabel,
        "description": config.barChartInformation,
        "showTitle": config.showTitle,
        "showYGrid": config.showYGrid,
        "showXGrid": config.showXGrid,
        "showYValues": config.showYValues,
        "showXValues": config.showXValues,
        "showXLabel": config.showXLabel,
        "showYLabel": config.showYLabel,
        "showZeroLine": config.showZeroLine,
        "barWidth": config.barWidth,
        "leftPanelValueCount": config.leftPanelValueCount,
        "xName": config.xName,
        "yName": config.yName,
        "showLabelsInBottomPanel": config.showLabelsInBottomPanel,
        "resizerWidth": constraints.resizerWidth,
        "yValueFloatingPointDigits": config.yValueFloatingPointDigits,
        "barXSpacing": config.barXSpacing,
        "rotateXLabels": config.rotateXLabels,
        "showResizerLines": config.showResizerLines,
        "enableCursorTracker": config.cursorTrackerEnabled,
        "enableBarOverlays": config.enableBarOverlays,
        "staticYGrid": config.staticYGrid,
        "xGridOpacity": config.xGridOpacity,
        "yGridOpacity": config.yGridOpacity,
        "topPanelBackgroundColor" : colorToMap(color: config.topPanelBackgroundColor),
        "leftPanelBackgroundColor": colorToMap(color: config.leftPanelBackgroundColor),
        "barChartBackgroundColor": colorToMap(color: config.barChartBackgroundColor),
        "bottomPanelBackgroundColor": colorToMap(color: config.bottomPanelBackgroundColor),
        "titleFontSize": config.titleFontSize,
        "titleFontColor": colorToMap(color: config.titleFontColor),
        "xLabelFontSize": config.xLabelFontSize,
        "xLabelFontColor": colorToMap(color: config.xLabelFontColor),
        "yLabelFontSize": config.yLabelFontSize,
        "yLabelFontColor": colorToMap(color: config.yLabelFontColor),
        "yValuesFontSize": config.yValuesFontSize,
        "yValuesFontColor": colorToMap(color: config.yValuesFontColor),
        "xValuesFontSize": config.xValuesFontSize,
        "xValuesFontColor": colorToMap(color: config.xLabelFontColor)
      };
      final constraintsMap = {
        "leftPanelFlexX": constraints.leftPanelSize.width.toInt(),
        "rightPanelFlexX": constraints.barChartSize.width.toInt(),
        "topPanelFlexY": constraints.topPanelSize.height.toInt(),
        "barChartFlexY": constraints.barChartSize.height.toInt(),
        "bottomPanelFlexY": constraints.bottomPanelSize.height.toInt()
      };
      final barsMap = [
        for (final b in bars)
          {
            "xValue": b.xValue,
            "yValue": b.yValue,
            "color": colorToMap(color: b.color)..["random"] = false,
            "xLabel": b.xLabel,
            "circularRadius": b.circularRadius,
            "outlined": b.outlined,
            "outlineWidth": b.outlineWidth
          }
      ];

      final map = {
        "settings": settingsMap,
        "constraints": constraintsMap,
        "bars": barsMap
      };

      final pretty = ("[\n${JsonEncoder.withIndent('\t').convert(map)}\n]");

      return pretty;
    }


    return Menu(
      menuTitle: "Save Config",
      isActive: activeMenu == BarChartMenu.save,

      children: [
        MenuListing(
            widget: ElevatedButton(
                onPressed: (){
                  FilePicker.saveFile(
                      fileName: "BarChartConfig.json",
                      bytes: utf8.encode(constructSavable()),
                  );
                },
                child: Text("Save To Computer")
            )
        )
      ],
    );
  }
}
