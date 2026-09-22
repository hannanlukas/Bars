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

1. Download and extract the latest release.
2. Open a command prompt in the extract folder.
3. Start the application by running : ‘start barchart.exe “[path to config.json]”’

Example : `start barchart.exe "C:/config.json"`

*Note: replace the [path to config.json] with the path to your configuration file.*

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
