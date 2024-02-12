import 'package:crafty_bay/presentation/state_holders/product_by_remark_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListByRemarkScreen extends StatefulWidget {
  const ProductListByRemarkScreen({super.key, required this.remark});

  final String remark;

  @override
  State<ProductListByRemarkScreen> createState() => _ProductListByRemarkScreenState();
}

class _ProductListByRemarkScreenState extends State<ProductListByRemarkScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.remark[0].toUpperCase() + widget.remark.substring(1)} Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GetBuilder<ProductByRemarkController>(
            tag: widget.remark,
            builder: (productByRemarkController) {
          return Visibility(
            visible:
                productByRemarkController.productListModel.productList?.isNotEmpty ??
                    false,
            replacement: const Center(
              child: Text('No Products'),
            ),
            child: Visibility(
              visible: productByRemarkController.inProgress == false,
              replacement: const CenterCircularProgressIndicator(),
              child: GridView.builder(
                itemCount:
                    productByRemarkController.productListModel.productList?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.90,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 4),
                itemBuilder: (context, index) {
                  return FittedBox(
                      child: ProductItemCard(
                    product:
                        productByRemarkController.productListModel.productList![index],
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
