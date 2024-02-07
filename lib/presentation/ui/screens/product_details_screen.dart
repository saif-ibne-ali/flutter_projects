import 'package:crafty_bay/data/models/product_details_data.dart';
import 'package:crafty_bay/presentation/state_holders/add_to_cart_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_details_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/validate_email_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/color_picker.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/product_image_carousel.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ValueNotifier<int> noOfItems = ValueNotifier(1);
  Color? _selectedColor;
  String? _selectedSize;

  @override
  void initState() {
    super.initState();
    Get.find<ProductDetailsController>().getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: GetBuilder<ProductDetailsController>(
          builder: (productDetailsController) {
        if (productDetailsController.inProgress) {
          return const CenterCircularProgressIndicator();
        }
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProductImageCarousel(
                      urls: [
                        productDetailsController.productDetails.img1 ?? '',
                        productDetailsController.productDetails.img2 ?? '',
                        productDetailsController.productDetails.img3 ?? '',
                        productDetailsController.productDetails.img4 ?? '',
                      ],
                    ),
                    productDetailsBody(productDetailsController.productDetails),
                  ],
                ),
              ),
            ),
            priceAndAddToCartSection,
          ],
        );
      }),
    );
  }

  Padding productDetailsBody(ProductDetailsData productDetails) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  productDetails.product?.title ?? '',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: noOfItems,
                  builder: (context, value, _) {
                    return ItemCount(
                      initialValue: value,
                      minValue: 1,
                      maxValue: 20,
                      onChanged: (v) {
                        noOfItems.value = v.toInt();
                      },
                      decimalPlaces: 0,
                      color: AppColors.primaryColor,
                    );
                  })
            ],
          ),
          const SizedBox(height: 8),
          reviewAndRatingRow(productDetails.product?.star ?? 0),
          const SizedBox(height: 8),
          const Text(
            'Color',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          // TODO : Fix the initial selected issue
          ColorPicker(
              colors: productDetails.color
                      ?.split(',')
                      .map((e) => getColorFromString(e))
                      .toList() ??
                  [],
              onChange: (selectedColor) {
                _selectedColor = selectedColor;
              }),
          const SizedBox(height: 8),
          const Text(
            'Size',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          // TODO : Fix the initial selected issue
          SizePicker(
              sizes: productDetails.size?.split(',') ?? [],
              onChange: (e) {
                _selectedSize = e;
              }),
          const SizedBox(height: 8),
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            productDetails.des ?? '',
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Row reviewAndRatingRow(int rating) {
    return Row(
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(
              Icons.star,
              size: 16,
              color: Colors.amber,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              rating.toStringAsPrecision(2),
              style: const TextStyle(
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
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
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                ),
              ),
              Text(
                '\$3200',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(
              width: 100,
              child: GetBuilder<AddToCartController>(
                  builder: (addToCartController) {
                return Visibility(
                  visible: addToCartController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (Get.find<AuthController>().isTokenNotNull) {
                        if (_selectedColor != null && _selectedSize != null) {
                          final stringColor = getStringFromColor(_selectedColor!);
                          final response = await addToCartController.addToCart(
                              widget.productId,
                              stringColor,
                              _selectedSize!);
                          if (response) {
                            Get.showSnackbar(const GetSnackBar(
                              title: 'Success',
                              message: 'The product has been added.',
                              duration: Duration(seconds: 2),
                            ));
                          } else {
                            Get.showSnackbar(GetSnackBar(
                              title: 'Add to cart failed',
                              message: addToCartController.errorMessage,
                              duration: const Duration(seconds: 2),
                            ));
                          }
                        }
                      } else {
                      Get.to(() => const ValidateEmailScreen());
                      }
                    },
                    child: const Text('Add to Cart'),
                  ),
                );
              }))
        ],
      ),
    );
  }

  Color getColorFromString(String colorCode) {
    String color = colorCode.toLowerCase();
    Map<String, Color> colorMap = {
      'white': Colors.white,
      'black': Colors.black,
      'red': Colors.red,
    };
    return colorMap[color] ?? Colors.black;
  }

  String getStringFromColor(Color colorCode) {
    Map<Color, String> colorMap = {
      Colors.white : 'White',
      Colors.black : 'Black',
      Colors.red : 'Red',
    };
    return colorMap[colorCode] ?? 'Black';
  }

  // Color getColorFromString(String colorCode) {
  //   String code = colorCode.replaceAll('#', '');
  //   String hexCode = 'FF$code';
  //   return Color(int.parse('0x$hexCode'));
  // }
  //
  // String getStringFromColor(String colorCode) {
  //   return colorCode.replaceAll('Color(0xff', '#').replaceAll(')', '');
  // }
}
