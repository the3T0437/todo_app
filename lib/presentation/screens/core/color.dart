import 'package:flutter/material.dart';

enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Orange', Colors.orange),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

class ColorDropDown extends StatefulWidget {
  ColorLabel color = ColorLabel.blue;

  @override
  State<StatefulWidget> createState() => _ColorDropDownState();
}

class _ColorDropDownState extends State<ColorDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<ColorLabel>(
      initialSelection: ColorLabel.green,
      // requestFocusOnTap is enabled/disabled by platforms when it is null.
      // On mobile platforms, this is false by default. Setting this to true will
      // trigger focus request on the text field and virtual keyboard will appear
      // afterward. On desktop platforms however, this defaults to true.
      requestFocusOnTap: true,
      label: const Text('Color'),
      onSelected: (ColorLabel? color) {
        setState(() {
          if (color != null) widget.color = color;
        });
      },
      dropdownMenuEntries:
          ColorLabel.values.map<DropdownMenuEntry<ColorLabel>>((
            ColorLabel color,
          ) {
            return DropdownMenuEntry<ColorLabel>(
              value: color,
              label: color.label,
              enabled: color.label != 'Grey',
              style: MenuItemButton.styleFrom(foregroundColor: color.color),
            );
          }).toList(),
    );
  }
}
