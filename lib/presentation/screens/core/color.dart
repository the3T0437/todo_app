// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  ColorDropDown({Key? key, ColorLabel? color})
    : color = color ?? ColorLabel.blue,
      super(key: key);

  @override
  State<StatefulWidget> createState() => _ColorDropDownState();
}

class _ColorDropDownState extends State<ColorDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<ColorLabel>(
      initialSelection: widget.color,
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
