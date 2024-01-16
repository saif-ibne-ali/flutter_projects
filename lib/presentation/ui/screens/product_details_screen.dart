import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/color_picker.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/product_image_carousel.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> noOfItems = ValueNotifier(1);
    List<Color> colors = [
      Colors.black,
      Colors.amber,
      Colors.red,
      Colors.green,
      Colors.blue
    ];
    List<String> sizes=[
      'S','L','M','XL','XXL','3XL'
    ];
    Color _selectedColor = colors.first;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ProductImageCarousel(),
                  productDetailsBody(noOfItems, colors, _selectedColor, sizes),
                ],
              ),
            ),
          ),
          priceAndAddToCartSection,
        ],
      ),
    );
  }

  Padding productDetailsBody(ValueNotifier<int> noOfItems, List<Color> colors, Color _selectedColor, List<String> sizes) {
    return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(child: Text('Walker Sneaker 2024 Edition Black Daimond- save 30%',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                          ),),),
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
                      ),
                      const SizedBox(height: 8 ),
                      Row(
                        children: [
                          const Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                '4.4',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black45),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'Reviews',
                            style: TextStyle(
                                fontSize: 16,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Card(
                            color: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            child: const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.favorite_outline_rounded,
                                size: 10,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text('Color',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),),
                      ColorPicker(colors: colors, onChange: (selectedColor){
                        _selectedColor = selectedColor;
                      }),
                      const SizedBox(height: 8),
                      const Text('Size',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),),
                      SizePicker(sizes: sizes, onChange: (e){}),
                      const SizedBox(height: 8),
                      const Text('Description',style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),),
                      const SizedBox(height: 8),
                      const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                      ),),
                    ],
                  ),
                );
  }

  Container get priceAndAddToCartSection {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.15),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price',style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black45,
              ),),
              Text('\$3200',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),),
            ],
          ),
          SizedBox(
              width: 100,
              child: ElevatedButton(onPressed: (){}, child: const Text('Add to Cart'),))
        ],
      ),
    );
  }

}

