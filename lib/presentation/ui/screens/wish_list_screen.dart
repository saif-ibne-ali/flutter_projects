import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wish_list_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {

  @override
  void initState() {
    super.initState();
    Get.find<WishListController>().getWishProductList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        Get.find<MainBottomNavController>().backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.find<MainBottomNavController>().backToHome();
            },
          ),
          title: const Text(
            'Wishlist',
            style: TextStyle(fontSize: 18),
          ),
          elevation: 3,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GetBuilder<WishListController>(
              builder: (wishListController) {
                return Visibility(
                  visible:
                  wishListController.wishListModel.productList?.isNotEmpty ??
                      false,
                  replacement: const Center(
                    child: Text('No Products'),
                  ),
                  child: Visibility(
                    visible: wishListController.inProgress == false,
                    replacement: const CenterCircularProgressIndicator(),
                    child: GridView.builder(
                      itemCount:
                      wishListController.wishListModel.productList?.length ?? 0,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.90,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 4),
                      itemBuilder: (context, index) {
                        return FittedBox(
                            child: ProductItemCard(
                              product:
                              wishListController.wishListModel.productList![index],
                            ));
                      },
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
