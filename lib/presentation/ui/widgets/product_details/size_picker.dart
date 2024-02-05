import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';

class SizePicker extends StatefulWidget {
  const SizePicker({super.key, required this.sizes, required this.onChange});

  final List<String> sizes;
  final Function(String) onChange;

  @override
  State<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {
  late String _selectedSize;

  @override
  void initState() {
    _selectedSize = widget.sizes.first;
    super.initState();
    widget.onChange(_selectedSize);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: widget.sizes.map((e) => InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: (){
          _selectedSize = e;
          widget.onChange(e);
          if(mounted){
            setState((){});
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
                color: Colors.grey
            ),
            color: _selectedSize == e ? AppColors.primaryColor : null,
          ),
          child:Text(e, style: TextStyle(
            color: _selectedSize == e ? Colors.white : Colors.black,
          ),),
        ),
      )).toList()
      ,
    );
  }
}