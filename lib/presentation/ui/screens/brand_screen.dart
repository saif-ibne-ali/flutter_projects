import 'package:crafty_bay/presentation/state_holders/brand_list_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/brand_item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({super.key});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Top Brands',
          style: TextStyle(fontSize: 18),
        ),
        elevation: 3,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Get.find<BrandListController>().getBrandList();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child:
              GetBuilder<BrandListController>(builder: (brandListController) {
            return Visibility(
              visible: brandListController.inProgress == false,
              replacement: const CenterCircularProgressIndicator(),
              child: GridView.builder(
                itemCount:
                    brandListController.brandListModel.brandList?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.95,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 8),
                itemBuilder: (context, index) {
                  return FittedBox(
                      child: BrandItemCard(
                    brand: brandListController.brandListModel.brandList![index],
                  ));
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
