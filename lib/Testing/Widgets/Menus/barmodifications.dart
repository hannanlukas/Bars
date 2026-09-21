import 'package:barchart/Testing/bars.dart';
import 'package:barchart/Testing/config.dart';
import 'package:barchart/Testing/constraints.dart';
import 'package:barchart/Testing/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:barchart/Testing/Widgets/menupicker.dart';



class BarModifications extends HookConsumerWidget{
  const BarModifications({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bars = ref.watch(BarChartGlobalBars.bars);
    final activeMenu = ref.watch(BarChartGlobalMenu.activeMenu);

    return Menu(
      isActive: activeMenu == BarChartMenu.barModifications,
      menuTitle: "Bar Modifications",
      children: [
        for (final (index, bar) in bars.indexed) ... [

          MenuListingDropdown(

            widget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      bar.xLabel,
                      style: GoogleFonts.googleSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: (bar.visible) ? Colors.black : Colors.grey[400]
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      'BAR $index',
                      style: GoogleFonts.googleSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                        color: Colors.black.withValues(alpha: 0.45),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            dropDownWidget: MenuListing(
                showBorder: false,
                widget: Column(
                  children: [


                    MenuListingCheckbox(
                        widget: Text("Visible", style: GoogleFonts.googleSans(),),
                        value: bar.visible,
                        onChanged: (val){
                          if (val == null) return;
                          ref.read(BarChartGlobalBars.bars.notifier).setVisibility(barIndex: index, value: val);
                        }
                    ),

                    Padding(padding: EdgeInsetsGeometry.all(4)),

                    MenuListingCheckbox(
                        widget: Text("Outlined", style: GoogleFonts.googleSans(),),
                        value: bar.outlined,
                        onChanged: (val){
                          if (val == null) return;
                          ref.read(BarChartGlobalBars.bars.notifier).setOutlined(barIndex: index, value: val);
                        }
                    ),


                    Padding(padding: EdgeInsetsGeometry.all(4)),

                    MenuListingDropdown(
                        widget: Text("Color", style: GoogleFonts.googleSans(),),
                        dropDownWidget: MenuListingColor(
                            widget: Text("Color", style: GoogleFonts.googleSans(),),
                            initialColor: bar.color,
                            onChanged: (color){
                              ref.read(BarChartGlobalBars.bars.notifier).setColor(barIndex: index, value: color);
                            }
                        )),

                    Padding(padding: EdgeInsetsGeometry.all(4)),

                    MenuListingDoubleInput(
                        widget: Text("Circular Radius", style: GoogleFonts.googleSans(),),
                        initialValue: bar.circularRadius,
                        minValue: 0.0,
                        maxValue: 1000.0,
                        onValidChange: (val){
                          ref.read(BarChartGlobalBars.bars.notifier).setCircularRadius(barIndex: index, value: val);
                        }
                    ),

                    Padding(padding: EdgeInsetsGeometry.all(4)),

                    if (bar.outlined)
                      MenuListingDoubleInput(
                          widget: Text("Outline Width", style: GoogleFonts.googleSans(),),
                          initialValue: bar.outlineWidth,
                          minValue: 0.0,
                          maxValue: 1000.0,
                          onValidChange: (val){
                            ref.read(BarChartGlobalBars.bars.notifier).setOutlineWidth(barIndex: index, value: val);
                          }
                      ),


                  ],
                )),
          ),


        ]

      ],
    );
  }

}