// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

enum ColorLabel {
  blue('Blue', Color.fromRGBO(209, 234, 237, 1)),
  pink('Pink', Color.fromRGBO(255, 218, 218, 1)),
  green('Green', Color.fromRGBO(157, 202, 164, 1)),
  yellow('Yellow', Color.fromRGBO(253, 242, 179, 1)),
  grey('Orange', Color.fromRGBO(255, 212, 169, 1));

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

/// A widget that displays a color picker table.
///
/// This widget allows users to select from predefined colors defined in [ColorLabel].
/// It displays a row of color options that can be tapped to select a color.
/// The selected color is highlighted with a background indicator.
///
/// The widget takes an optional [color] parameter to set the initial selected color.
/// If no color is provided, it defaults to [ColorLabel.blue].

class ColorTable extends StatefulWidget {
  ColorLabel color = ColorLabel.blue;

  ColorTable({Key? key, ColorLabel? color})
    : color = color ?? ColorLabel.blue,
      super(key: key);

  @override
  State<StatefulWidget> createState() => _ColorTableState();
}

class _ColorTableState extends State<ColorTable> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          ColorLabel.values.map<Widget>((ColorLabel color) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                setState(() {
                  widget.color = color;
                });
              },
              child: colorToPick(color, widget.color),
            );
          }).toList(),
    );
  }

  Widget colorToPick(ColorLabel color, ColorLabel selectedColor) {
    return Container(
      margin: const EdgeInsets.all(4),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color:
            color.label == selectedColor.label
                ? const Color.fromARGB(20, 59, 63, 65)
                : const Color.fromARGB(0, 0, 0, 0),
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox.shrink(
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: color.color,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
