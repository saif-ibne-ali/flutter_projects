import 'package:crafty_bay/presentation/state_holders/product_by_brand_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_by_category_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListByBrandScreen extends StatefulWidget {
  const ProductListByBrandScreen({super.key, this.brand, this.brandId});

  final String? brand;
  final int? brandId;

  @override
  State<ProductListByBrandScreen> createState() => _ProductListByBrandScreenState();
}

class _ProductListByBrandScreenState extends State<ProductListByBrandScreen> {
  @override
  void initState() {
    if (widget.brandId != null) {
      Get.find<ProductByCategoryController>()
          .getProductList(categoryId: widget.brandId!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.brand ?? 'Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GetBuilder<ProductByBrandController>(builder: (productByBrandController) {
          return Visibility(
            visible:
                productByBrandController.productListModel.productList?.isNotEmpty ??
                    false,
            replacement: const Center(
              child: Text('No Products'),
            ),
            child: Visibility(
              visible: productByBrandController.inProgress == false,
              replacement: const CenterCircularProgressIndicator(),
              child: GridView.builder(
                itemCount:
                    productByBrandController.productListModel.productList?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.90,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 4),
                itemBuilder: (context, index) {
                  return FittedBox(
                      child: ProductItemCard(
                    product:
                        productByBrandController.productListModel.productList![index],
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
