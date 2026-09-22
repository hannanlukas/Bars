<h1 align="center">Bars</h1>

**Overview**

A modern, fully customisable bar chart viewer designed to provide the user full control of how they want their data visually represented. Offering a fully portable and dependency-less executable, requiring only a config file specified as a launch parameter, meaning any language will be capable of utilising it without the need for an external package.

**Features**

- Fully Customisable: Customise how you want the colours/sizes/font sizes/window sizes to look and decide which components should be visible or hidden.
- Bar Sort: Sort the order of the bars on the fly deciding whether to use a pre-defined sort order, or a customised sort order.
- Individual Bar Customisation: Hide or customise a single bar, to have it either stand out/blend in, or view the data without it.
- Overlay: Hover the mouse over a bar to view it’s X, Y, and X Label providing a useful way of viewing the individual bar data when the data is very condensed.
- Resizable: Resizable panels for resizing how much of the chart takes up the main window.
- Signed & Unsinged Y Values: Both positive and negative Y values can be used at the same time, with the negative values scaling down rather than up.
- & Many More.

**Menu Features**

- Settings: Configure the visual style of the chart on the fly without needing to reload.
- Information: Explain what the chart is representing and any further information related to it.
- Bar Modifications: Hide specific bars or customise their visual style.
- Bar Sorter: Reorder the bars based on either a pre-defined sort, or a custom sort.
- Save: Save the config file to be exactly how they had it setup in application.
- Config Warnings: View any warnings related to parsing the config.

**Getting Started**

1. Download and extract the [latest release](https://github.com/hannanlukas/Bars/releases).
3. Open a command prompt in the extract folder.
4. Start the application by running : ‘start barchart.exe “[path to config.json]”’

Example : `start barchart.exe "C:/config.json"`

*Note: replace the [path to config.json] with the path to your configuration file. You can use the example configuation below to get started.*

<details>
  <summary><b>Example Configuration</b></summary>
  
  ```json
[
    {
  	"settings": {
  	  "title": "Worthiness Of Fruit",
  	  "xLabelForValues": "Cost",
  	  "xLabelForNames": "Fruit Type",
  	  "yLabel": "Enjoyment Rating",
  	  "description": "This bar chart compares the cost of fruit against how much the fruit is enjoyed, with the maximum rating being 10, and the minimum rating being -10.",
  	  "showTitle": true,
  	  "showYGrid": true,
  	  "showXGrid": true,
  	  "showYValues": true,
  	  "showXValues": true,
  	  "showXLabel": true,
  	  "showYLabel": true,
  	  "showZeroLine": true,
  	  "barWidth": 50.0,
  	  "leftPanelValueCount": 9,
  	  "xName": "Cost",
  	  "yName": "Rating",
  	  "showLabelsInBottomPanel": false,
  	  "resizerWidth": 3.0,
  	  "yValueFloatingPointDigits": 2,
  	  "barXSpacing": 25.0,
  	  "rotateXLabels": true,
  	  "showResizerLines": false,
  	  "enableCursorTracker": true,
  	  "enableBarOverlays": true,
  	  "staticYGrid": false,
  	  "xGridOpacity": 0.1,
  	  "yGridOpacity": 0.1,
  	  "topPanelBackgroundColor": {"r": 250, "g": 250, "b": 250, "a": 255},
  	  "leftPanelBackgroundColor": {"r": 250, "g": 250, "b": 250, "a": 255},
  	  "barChartBackgroundColor": {"r": 255, "g": 255, "b": 255, "a": 255},
  	  "bottomPanelBackgroundColor": {"r": 250, "g": 250, "b": 250, "a": 255},
  	  "titleFontSize": 24.0,
  	  "titleFontColor": {"r": 0, "g": 0, "b": 0, "a": 255},
  	  "xLabelFontSize": 16.0,
  	  "xLabelFontColor": {"r": 0, "g": 0, "b": 0, "a": 255},
  	  "yLabelFontSize": 16.0,
  	  "yLabelFontColor": {"r": 0, "g": 0, "b": 0, "a": 255},
  	  "yValuesFontSize": 12.0,
  	  "yValuesFontColor": {"r": 0, "g": 0, "b": 0, "a": 255},
  	  "xValuesFontSize": 12.0,
  	  "xValuesFontColor": {"r": 0, "g": 0, "b": 0, "a": 255}
  	},
  	"constraints": {
  	  "leftPanelFlexX" : 1,
  	  "rightPanelFlexX": 9,
  	  "topPanelFlexY": 1,
  	  "barChartFlexY": 8,
  	  "bottomPanelFlexY": 1
  	},
  	"bars": [
  	  {"xValue": 1.50, "yValue": 5.0, "color": {"r": 255, "g": 0, "b": 0, "a": 255, "random": false}, "xLabel": "Apple", "circularRadius" : 0.0, "outlined" : false, "outlineWidth" : 1.0},
  	  {"xValue": 1.00, "yValue": -2.0, "color": {"r": 0, "g": 255, "b": 0, "a": 255, "random": false}, "xLabel": "Pear", "circularRadius" : 0.0, "outlined" : false, "outlineWidth" : 1.0},
  	  {"xValue": 0.80, "yValue": 9.0, "color": {"r": 255, "g": 163, "b": 0, "a": 255, "random": false}, "xLabel": "Orange", "circularRadius" : 0.0, "outlined" : false, "outlineWidth" : 1.0},
  	  {"xValue": 1.80, "yValue": 4.0, "color": {"r": 248, "g": 255, "b": 0, "a": 255, "random": false}, "xLabel": "Banana", "circularRadius" : 0.0, "outlined" : false, "outlineWidth" : 1.0},
  	  {"xValue": 2.50, "yValue": 10.0, "color": {"r": 220, "g": 20, "b": 60, "a": 255, "random": false}, "xLabel": "Strawberry", "circularRadius" : 0.0, "outlined" : false, "outlineWidth" : 1.0},
  	  {"xValue": 3.00, "yValue": 8.0, "color": {"r": 138, "g": 43, "b": 226, "a": 255, "random": false}, "xLabel": "Blueberry", "circularRadius" : 0.0, "outlined" : false, "outlineWidth" : 1.0},
  	  {"xValue": 4.50, "yValue": 7.5, "color": {"r": 106, "g": 13, "b": 173, "a": 255, "random": false}, "xLabel": "Mango", "circularRadius" : 0.0, "outlined" : false, "outlineWidth" : 1.0},
  	  {"xValue": 5.00, "yValue": -8.0, "color": {"r": 143, "g": 188, "b": 143, "a": 255, "random": false}, "xLabel": "Durian", "circularRadius" : 0.0, "outlined" : false, "outlineWidth" : 1.0},
  	  {"xValue": 3.50, "yValue": -5.0, "color": {"r": 255, "g": 20, "b": 147, "a": 255, "random": false}, "xLabel": "Dragonfruit", "circularRadius" : 0.0, "outlined" : false, "outlineWidth" : 1.0},
  	  {"xValue": 20.0, "yValue": 6.5, "color": {"r": 50, "g": 205, "b": 50, "a": 255, "random": false}, "xLabel": "Kiwi", "circularRadius" : 0.0, "outlined" : false, "outlineWidth" : 1.0}
  	]
    }
]
```

</details>

**Dependencies**

*Note: The dependencies are only required for compiling the application*

- [Riverpod](https://pub.dev/packages/riverpod) `^3.3.2`
- [Flutter Hooks](https://pub.dev/packages/flutter_hooks) `^0.21.3+1`
- [Hooks Riverpod](https://pub.dev/packages/hooks_riverpod) `^3.3.2`
- [Flutter Colorpicker](https://pub.dev/packages/flutter_colorpicker) `^1.1.0`
- [Google Fonts](https://pub.dev/packages/google_fonts) `^8.2.1`
- [Window Manager](https://pub.dev/packages/window_manager) `^0.5.1`
- [File Picker](https://pub.dev/packages/file_picker) `^13.1.0`

**Preview**
<table>
  <tr>
    <td align="center" width="33.3%">
      <b>Pan & Zoom</b><br><br>
      <img src="https://github.com/user-attachments/assets/4330a8e5-8007-4456-abaa-d92f26058fc1" width="100%" />
    </td>
    <td align="center" width="33.3%">
      <b>Resize Panels</b><br><br>
      <img src="https://github.com/user-attachments/assets/f49a6700-af61-407e-b454-da72c5e7923f" width="100%" />
    </td>
    <td align="center" width="33.3%">
      <b>Overlay</b><br><br>
      <img src="https://github.com/user-attachments/assets/3352c421-a977-4533-bb09-7b54fab37f08" width="100%" />
    </td>
  </tr>
</table>

<table>
  <tr>
    <td align="center" width="33.3%">
      <b>Settings</b><br><br>
      <img src="https://github.com/user-attachments/assets/e22d78bb-a91a-4288-8c6e-d7b5894d77fb" width="100%" />
    </td>
    <td align="center" width="33.3%">
      <b>Reset View</b><br><br>
      <img src="https://github.com/user-attachments/assets/b178fb01-0f37-435a-b1b4-777ccdbd3cff" width="100%" />
    </td>
    <td align="center" width="33.3%">
      <b>Information</b><br><br>
      <img src="https://github.com/user-attachments/assets/c1b01961-7ab0-45eb-b85e-0e46935986f4" width="100%" />
    </td>
  </tr>
</table>

<table>
  <tr>
    <td align="center" width="33.3%">
      <b>Bar Modifications</b><br><br>
      <img src="https://github.com/user-attachments/assets/20fe875b-e06c-4908-ae36-71be6c05e8fa" width="100%" />
    </td>
    <td align="center" width="33.3%">
      <b>Bar Sorter</b><br><br>
      <img src="https://github.com/user-attachments/assets/ae661cca-cf66-44d7-bdcd-c191e5de1d62" width="100%" />
    </td>
    <td align="center" width="33.3%">
      <b>Warnings & Config Save</b><br><br>
      <img src="https://github.com/user-attachments/assets/04f38b03-160d-4135-b33e-4b6a96a86a99" width="100%" />
    </td>
  </tr>
</table>
