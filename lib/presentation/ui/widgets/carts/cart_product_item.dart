import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class CartProductItem extends StatelessWidget {
  const CartProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> noOfItems = ValueNotifier(1);
    return Card(
      elevation: 3,
      child: Row(
        children: [
          Image.asset(AssetsPath.dummyShoeImageJpg, width: 100,),
          const SizedBox(
            width: 8,
          ),
          Expanded(child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Walker Sneaker Alpha 2024',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54
                        ),),
                      Row(
                        children: [
                          Text('Color: Black'),
                          SizedBox(width: 8,),
                          Text('Size: XL')
                        ],
                      ),
                    ],
                  ),),
                  IconButton(onPressed: (){},
                    icon: const Icon(Icons.delete_forever_outlined,
                      color: Colors.grey,),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('\$100',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),),
                  ValueListenableBuilder(
                      valueListenable: noOfItems,
                      builder: (context, value, _) {
                        return ItemCount(
                          initialValue: value,
                          minValue: 1,
                          maxValue: 20,
                          onChanged: (v){
                            noOfItems.value = v.toInt();
                          },
                          decimalPlaces: 0,
                          color: AppColors.primaryColor,
                        );
                      }
                  )
                ],
              )
            ],
          ),),
        ],
      ),
    );
  }
}