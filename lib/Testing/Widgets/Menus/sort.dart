import 'package:barchart/Testing/bars.dart';
import 'package:barchart/Testing/config.dart';
import 'package:barchart/Testing/constraints.dart';
import 'package:barchart/Testing/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:barchart/Testing/Widgets/menupicker.dart';

class BarSort extends HookConsumerWidget{
  const BarSort({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final sortOrder = ref.watch(BarChartGlobalBars.sortOrder);
    final activeMenu = ref.watch(BarChartGlobalMenu.activeMenu);

    return Menu(
      menuTitle: "Bar Sorter",
      isActive: activeMenu == BarChartMenu.barSorter,
      children: [
        MenuListingCheckbox(
            widget: Text("Insertion Order", style: GoogleFonts.googleSans(),),
            value: sortOrder == BarsSortOrder.insertionIndex,
            onChanged: (val){
              if (val != null && val == true){
                ref.read(BarChartGlobalBars.sortOrder.notifier).set(order: BarsSortOrder.insertionIndex);
                ref.read(BarChartGlobalBars.bars.notifier).sortByInsertionIndex();
              }
            }
        ),
        MenuListingCheckbox(
            widget: Text("Smallest To Greatest X", style: GoogleFonts.googleSans()),
            value: sortOrder == BarsSortOrder.smallestToGreatestX,
            onChanged: (val){
              if (val != null && val == true){
                ref.read(BarChartGlobalBars.sortOrder.notifier).set(order: BarsSortOrder.smallestToGreatestX);
                ref.read(BarChartGlobalBars.bars.notifier).sortSmallestToGreatestX();
              }
            }
        ),
        MenuListingCheckbox(
            widget: Text("Greatest To Smallest X", style: GoogleFonts.googleSans()),
            value: sortOrder == BarsSortOrder.greatestToSmallestX,
            onChanged: (val){
              if (val != null && val == true){
                ref.read(BarChartGlobalBars.sortOrder.notifier).set(order: BarsSortOrder.greatestToSmallestX);
                ref.read(BarChartGlobalBars.bars.notifier).sortGreatestToSmallestX();
              }
            }
        ),
        MenuListingCheckbox(
            widget: Text("Smallest To Greatest Y", style: GoogleFonts.googleSans()),
            value: sortOrder == BarsSortOrder.smallestToGreatestY,
            onChanged: (val){
              if (val != null && val == true){
                ref.read(BarChartGlobalBars.sortOrder.notifier).set(order: BarsSortOrder.smallestToGreatestY);
                ref.read(BarChartGlobalBars.bars.notifier).sortSmallestToGreatestY();
              }
            }
        ),
        MenuListingCheckbox(
            widget: Text("Greatest To Smallest Y", style: GoogleFonts.googleSans()),
            value: sortOrder == BarsSortOrder.greatestToSmallestY,
            onChanged: (val){
              if (val != null && val == true){
                ref.read(BarChartGlobalBars.sortOrder.notifier).set(order: BarsSortOrder.greatestToSmallestY);
                ref.read(BarChartGlobalBars.bars.notifier).sortGreatestToSmallestY();
              }
            }
        ),
        MenuListingCheckboxWithExpansion(
            widget: Text("Custom", style: GoogleFonts.googleSans()),
            value: sortOrder == BarsSortOrder.custom,
            onChanged: (val){
              if (val != null && val == true){
                ref.read(BarChartGlobalBars.sortOrder.notifier).set(order: BarsSortOrder.custom);
              }
            },
            expansion: CustomBarSorter()
        ),


      ],
    );
  }

}



class CustomBarSorter extends ConsumerWidget {
  const CustomBarSorter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bars = ref.watch(BarChartGlobalBars.bars);

    return ReorderableListView.builder(
      proxyDecorator: (child, index, animation) {
        return child;
      },
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: bars.length,
      onReorder: (oldIndex, newIndex) {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        ref.read(BarChartGlobalBars.bars.notifier).reorderBar(barIndex: oldIndex, newBarIndex: newIndex);
      },
      itemBuilder: (context, index) {
        final bar = bars[index];
        return Container(
          key: ValueKey(bar),
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withValues(alpha: 0.12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.025),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(10, 6, 10, 10),
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    bar.xLabel,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.googleSans()
                  ),
                ),
              ),

              Expanded(
                child: Center(
                  child: Text(
                    "X : ${bar.xValue.toStringAsFixed(2)}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.googleSans()
                  ),
                ),
              ),

              Expanded(
                child: Center(
                  child: Text(
                    "Y : ${bar.yValue.toStringAsFixed(2)}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.googleSans()
                  ),
                ),
              ),

              Expanded(
                child: Center(
                  child: Container(
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
                ),
              ),

              SizedBox(width: 24)
            ],
          ),
        );
      },
    );
  }
}