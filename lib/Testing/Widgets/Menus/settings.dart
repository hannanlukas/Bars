import 'package:barchart/Testing/config.dart';
import 'package:barchart/Testing/constraints.dart';
import 'package:barchart/Testing/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:barchart/Testing/Widgets/menupicker.dart';

class SettingsMenu extends HookConsumerWidget {
  const SettingsMenu({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final config = ref.watch(BarChartGlobalConfig.configNotifier);
    final constraints = ref.watch(BarChartGlobalConstraints.constraints);
    final activeMenu = ref.watch(BarChartGlobalMenu.activeMenu);

    return Menu(
      isActive: activeMenu == BarChartMenu.settings,
      menuTitle: "Settings",
      children: [

        MenuListingDropdown(
          widget: Text("Visibility"),
          dropDownWidget: Column(
            spacing: 10.0,
            children: [
              MenuListingCheckbox(
                  widget: Text("Show Title", style: GoogleFonts.googleSans(),),
                  value: config.showTitle,
                  onChanged: (val){
                    if (val == null){
                      return;
                    }
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(showTitle: val));
                  }
              ),
              MenuListingCheckbox(
                  widget: Text("Show X Grid", style: GoogleFonts.googleSans()),
                  value: config.showXGrid,
                  onChanged: (val){
                    if (val == null){
                      return;
                    }
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(showXGrid: val));
                  }
              ),
              MenuListingCheckbox(
                  widget: Text("Show Y Grid", style: GoogleFonts.googleSans(),),
                  value: config.showYGrid,
                  onChanged: (val){
                    if (val == null){
                      return;
                    }
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(showYGrid: val));
                  }
              ),
              MenuListingCheckbox(
                  widget: Text("Show Y Values", style: GoogleFonts.googleSans()),
                  value: config.showYValues,
                  onChanged: (val){
                    if (val == null){
                      return;
                    }
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(showYValues: val));
                  }
              ),
              MenuListingCheckbox(
                  widget: Text("Show X Values", style: GoogleFonts.googleSans(),),
                  value: config.showXValues,
                  onChanged: (val){
                    if (val == null){
                      return;
                    }
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(showXValues: val));
                  }
              ),
              MenuListingCheckbox(
                  widget: Text("Show X Label", style: GoogleFonts.googleSans(),),
                  value: config.showXLabel,
                  onChanged: (val){
                    if (val == null){
                      return;
                    }
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(showXLabel: val));
                  }
              ),
              MenuListingCheckbox(
                  widget: Text("Show Y Label", style: GoogleFonts.googleSans(),),
                  value: config.showYLabel,
                  onChanged: (val){
                    if (val == null){
                      return;
                    }
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(showYLabel: val));
                  }
              ),
              MenuListingCheckbox(
                  widget: Text("Show Zero Y Line", style: GoogleFonts.googleSans(),),
                  value: config.showZeroLine,
                  onChanged: (val){
                    if (val == null){
                      return;
                    }
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(showZeroLine: val));
                  }
              ),
              MenuListingCheckbox(
                  widget: Text("Show Resizer Lines", style: GoogleFonts.googleSans(),),
                  value: config.showResizerLines,
                  onChanged: (val){
                    if (val == null){
                      return;
                    }
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(showResizerLines: val));
                  }
              ),

            ],
          ),
        ),

        MenuListingDropdown(
          widget: Text("Functionality", style: GoogleFonts.googleSans(),),
          dropDownWidget: Column(
            spacing: 10.0,
            children: [
              MenuListingCheckbox(
                  widget: Text("Enable Bar Overlays", style: GoogleFonts.googleSans(),),
                  value: config.enableBarOverlays,
                  onChanged: (val){
                    if (val == null){
                      return;
                    }
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(enableBarOverlays: val));
                  }
              ),
              MenuListingCheckbox(
                  widget: Text("Enable Static Y Grid", style: GoogleFonts.googleSans(),),
                  value: config.staticYGrid,
                  onChanged: (val){
                    if (val == null){
                      return;
                    }
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(staticYGrid: val));
                  }
              ),
              MenuListingCheckbox(
                  widget: Text("Enable Bar Labels In Bottom Panel", style: GoogleFonts.googleSans(),),
                  value: config.showLabelsInBottomPanel,
                  onChanged: (val){
                    if (val == null){
                      return;
                    }
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(showLabelsInBottomPanel: val));
                  }
              ),
              MenuListingCheckbox(
                  widget: Text("Enable Rotated X Labels", style: GoogleFonts.googleSans(),),
                  value: config.rotateXLabels,
                  onChanged: (val){
                    if (val == null){
                      return;
                    }
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(rotateXLabels: val));
                  }
              ),
              MenuListingCheckbox(
                  widget: Text("Enable Cursor Tracker", style: GoogleFonts.googleSans(),),
                  value: config.cursorTrackerEnabled,
                  onChanged: (val){
                    if (val == null){
                      return;
                    }
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(cursorTrackerEnabled: val));
                  }
              ),
            ],
          ),
        ),

        MenuListingDropdown(
          widget: Text("Style", style: GoogleFonts.googleSans(),),
          dropDownWidget: Column(
            spacing: 10.0,
            children: [

              MenuListingDoubleInput(
                  widget: Text("X Grid Opacity", style: GoogleFonts.googleSans(),),
                  initialValue: config.xGridOpacity,
                  minValue: 0.0,
                  maxValue: 1.0,
                  onValidChange: (val){
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(xGridOpacity: val));
                  }
              ),
              MenuListingDoubleInput(
                  widget: Text("Y Grid Opacity", style: GoogleFonts.googleSans(),),
                  initialValue: config.yGridOpacity,
                  minValue: 0.0,
                  maxValue: 1.0,
                  onValidChange: (val){
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(yGridOpacity: val));
                  }
              ),
              MenuListingDoubleInput(
                  widget: Text("Bar Width", style: GoogleFonts.googleSans(),),
                  initialValue: config.barWidth,
                  minValue: 1.0,
                  maxValue: double.maxFinite,
                  onValidChange: (val){
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(barWidth: val));
                  }
              ),
              MenuListingDoubleInput(
                  widget: Text("Bar Spacing", style: GoogleFonts.googleSans(),),
                  initialValue: config.barXSpacing,
                  minValue: 0.0,
                  maxValue: double.maxFinite,
                  onValidChange: (val){
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(barXSpacing: val));
                  }
              ),
              MenuListingIntInput(
                  widget: Text("Y Value Count", style: GoogleFonts.googleSans(),),
                  initialValue: config.leftPanelValueCount + 1,
                  minValue: 2,
                  maxValue: 10000,
                  onValidChange: (val){
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(leftPanelValueCount: val - 1));
                  }
              ),
              MenuListingIntInput(
                  widget: Text("Y Value Floating Point Digits", style: GoogleFonts.googleSans(),),
                  initialValue: config.yValueFloatingPointDigits,
                  minValue: 0,
                  maxValue: 16,
                  onValidChange: (val){
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(yValueFloatingPointDigits: val));
                  }
              ),
              MenuListingDoubleInput(
                  widget: Text("Resizer Width", style: GoogleFonts.googleSans(),),
                  initialValue: constraints.resizerWidth,
                  minValue: 1.0,
                  maxValue: double.maxFinite,
                  onValidChange: (val){
                    ref.read(BarChartGlobalConstraints.constraints.notifier).set(constraints: constraints.copyWithResizerWidth(resizerWidth: val));
                  }
              ),

            ],
          ),
        ),

        MenuListingDropdown(
          widget: Text("Backgrounds", style: GoogleFonts.googleSans(),),
          dropDownWidget: Column(
            spacing: 10.0,
            children: [

              MenuListingDropdown(
                  widget: Text("Top Panel Background Color", style: GoogleFonts.googleSans(),),
                  dropDownWidget: MenuListingColor(
                      initialColor: config.topPanelBackgroundColor,
                      onChanged: (color){
                        ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(topPanelBackgroundColor: color));
                      }
                  )
              ),
              MenuListingDropdown(
                  widget: Text("Left Panel Background Color", style: GoogleFonts.googleSans(),),
                  dropDownWidget: MenuListingColor(
                      initialColor: config.leftPanelBackgroundColor,
                      onChanged: (color){
                        ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(leftPanelBackgroundColor: color));
                      }
                  )
              ),
              MenuListingDropdown(
                  widget: Text("Bar Chart Background Color", style: GoogleFonts.googleSans(),),
                  dropDownWidget: MenuListingColor(
                      initialColor: config.barChartBackgroundColor,
                      onChanged: (color){
                        ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(barChartBackgroundColor: color));
                      }
                  )
              ),
              MenuListingDropdown(
                  widget: Text("Bottom Panel Background Color", style: GoogleFonts.googleSans(),),
                  dropDownWidget: MenuListingColor(
                      initialColor: config.bottomPanelBackgroundColor,
                      onChanged: (color){
                        ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(bottomPanelBackgroundColor: color));
                      }
                  )
              ),

            ],
          ),
        ),

        MenuListingDropdown(
          widget: Text("Fonts", style: GoogleFonts.googleSans(),),
          dropDownWidget: Column(
            spacing: 10.0,
            children: [

              MenuListingDoubleInput(
                  widget: Text("Title Font Size", style: GoogleFonts.googleSans(),),
                  initialValue: config.titleFontSize,
                  minValue: 1.0,
                  maxValue: double.infinity,
                  onValidChange: (value){
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(titleFontSize: value));
                  }
              ),
              MenuListingDoubleInput(
                  widget: Text("X Label Font Size", style: GoogleFonts.googleSans(),),
                  initialValue: config.xLabelFontSize,
                  minValue: 1.0,
                  maxValue: double.infinity,
                  onValidChange: (value){
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(xLabelFontSize: value));
                  }
              ),
              MenuListingDoubleInput(
                  widget: Text("Y Label Font Size", style: GoogleFonts.googleSans(),),
                  initialValue: config.yLabelFontSize,
                  minValue: 1.0,
                  maxValue: double.infinity,
                  onValidChange: (value){
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(yLabelFontSize: value));
                  }
              ),
              MenuListingDoubleInput(
                  widget: Text("X Values Font Size", style: GoogleFonts.googleSans(),),
                  initialValue: config.xValuesFontSize,
                  minValue: 1.0,
                  maxValue: double.infinity,
                  onValidChange: (value){
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(xValuesFontSize: value));
                  }
              ),
              MenuListingDoubleInput(
                  widget: Text("Y Values Font Size", style: GoogleFonts.googleSans(),),
                  initialValue: config.yValuesFontSize,
                  minValue: 1.0,
                  maxValue: double.infinity,
                  onValidChange: (value){
                    ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(yValuesFontSize: value));
                  }
              ),

              MenuListingDropdown(
                  widget: Text("Title Font Color", style: GoogleFonts.googleSans(),),
                  dropDownWidget: MenuListingColor(
                      initialColor: config.titleFontColor,
                      onChanged: (color){
                        ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(titleFontColor: color));
                      }
                  )
              ),
              MenuListingDropdown(
                  widget: Text("X Label Font Color", style: GoogleFonts.googleSans(),),
                  dropDownWidget: MenuListingColor(
                      initialColor: config.xLabelFontColor,
                      onChanged: (color){
                        ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(xLabelFontColor: color));
                      }
                  )
              ),
              MenuListingDropdown(
                  widget: Text("Y Label Font Color", style: GoogleFonts.googleSans(),),
                  dropDownWidget: MenuListingColor(
                      initialColor: config.yLabelFontColor,
                      onChanged: (color){
                        ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(yLabelFontColor: color));
                      }
                  )
              ),
              MenuListingDropdown(
                  widget: Text("X Values Font Color", style: GoogleFonts.googleSans(),),
                  dropDownWidget: MenuListingColor(
                      initialColor: config.xValuesFontColor,
                      onChanged: (color){
                        ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(xValuesFontColor: color));
                      }
                  )
              ),
              MenuListingDropdown(
                  widget: Text("Y Values Font Color", style: GoogleFonts.googleSans(),),
                  dropDownWidget: MenuListingColor(
                      initialColor: config.yValuesFontColor,
                      onChanged: (color){
                        ref.read(BarChartGlobalConfig.configNotifier.notifier).set(newConfig: config.copyWith(yValuesFontColor: color));
                      }
                  )
              ),

            ],
          ),
        ),

      ],
    );
  }
}
