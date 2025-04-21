// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

enum ColorLabel {
  pink('Blue', Color.fromRGBO(209, 234, 237, 1)),
  blue('Pink', Color.fromRGBO(255, 218, 218, 1)),
  green('Green', Color.fromRGBO(157, 202, 164, 1)),
  yellow('Yellow', Color.fromRGBO(253, 242, 179, 1)),
  grey('Orange', Color.fromRGBO(255, 212, 169, 1));

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
