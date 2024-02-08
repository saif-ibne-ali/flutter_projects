import 'package:crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/carts/cart_product_item.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CartListController>().getCartList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_){
        Get.find<MainBottomNavController>().backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
          leading: IconButton(onPressed: (){
            Get.find<MainBottomNavController>().backToHome();
          },
            icon: const Icon(Icons.arrow_back_ios),),
        ),
        body: GetBuilder<CartListController>(
          builder: (cartListController) {
            if(cartListController.inProgress == true){
              return const CenterCircularProgressIndicator();
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index){
                        return CartProductItem(
                          cartItem: cartListController.cartList.cartItemList![index],);
                      },
                      separatorBuilder: (_,__)=> const SizedBox(),
                      itemCount: cartListController.cartList.cartItemList?.length ?? 0,),
                ),
                totalPriceAndCheckoutSection
              ],
            );
          }
        ),
      ),
    );
  }

  Container get totalPriceAndCheckoutSection {
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
                    Text('Total Price',style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black45,
                    ),),
                    Text('৳3200',style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),),
                  ],
                ),
                SizedBox(
                  width: 100,
                    child: ElevatedButton(onPressed: (){}, child: const Text('Checkout'),))
              ],
            ),
          );
  }
}

