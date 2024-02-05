import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key, required this.colors, required this.onChange});

  final List<Color> colors;
  final Function(Color) onChange;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color _selectedColor;

  @override
  void initState() {
    _selectedColor = widget.colors.first;
    super.initState();
    widget.onChange(_selectedColor);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: widget.colors.map((e) => InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: (){
          _selectedColor = e;
          widget.onChange(e);
          if(mounted){
            setState((){});
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            radius: 15,
            backgroundColor: e,
            child: _selectedColor == e ? const Icon(Icons.done,color: Colors.white,) : null,
          ),
        ),
      )).toList()
      ,
    );
  }
}