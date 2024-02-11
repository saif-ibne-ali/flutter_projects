import 'package:crafty_bay/presentation/state_holders/product_by_category_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListByCategoryScreen extends StatefulWidget {
  const ProductListByCategoryScreen({super.key, this.category, this.categoryId});

  final String? category;
  final int? categoryId;

  @override
  State<ProductListByCategoryScreen> createState() => _ProductListByCategoryScreenState();
}

class _ProductListByCategoryScreenState extends State<ProductListByCategoryScreen> {
  @override
  void initState() {
    if (widget.categoryId != null) {
      Get.find<ProductByCategoryController>()
          .getProductList(categoryId: widget.categoryId!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category ?? 'Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GetBuilder<ProductByCategoryController>(builder: (productController) {
          return Visibility(
            visible:
                productController.productListModel.productList?.isNotEmpty ??
                    false,
            replacement: const Center(
              child: Text('No Products'),
            ),
            child: Visibility(
              visible: productController.inProgress == false,
              replacement: const CenterCircularProgressIndicator(),
              child: GridView.builder(
                itemCount:
                    productController.productListModel.productList?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.90,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 4),
                itemBuilder: (context, index) {
                  return FittedBox(
                      child: ProductItemCard(
                    product:
                        productController.productListModel.productList![index],
                  ));
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
