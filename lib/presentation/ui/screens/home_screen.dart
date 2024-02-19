import 'package:crafty_bay/data/models/product_model.dart';
import 'package:crafty_bay/presentation/state_holders/brand_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/category_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/home_banner_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_by_remark_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/read_profile_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/brand_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/product_list_by_remark_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:crafty_bay/presentation/ui/widgets/category_item_card.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/circle_icon_button.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/banner_carousel.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/section_title.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/brand_item_card.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: RefreshIndicator(
        onRefresh: () async {
          Get.find<HomeBannerController>().getBannerList();
          Get.find<BrandListController>().getBrandList();
          Get.find<CategoryListController>().getCategoryList();
          Get.find<ProductByRemarkController>(tag: 'trending').getProductList();
          Get.find<ProductByRemarkController>(tag: 'popular').getProductList();
          Get.find<ProductByRemarkController>(tag: 'special').getProductList();
          Get.find<ProductByRemarkController>(tag: 'new').getProductList();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                searchTextField,
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 220,
                  child: GetBuilder<HomeBannerController>(
                      builder: (homeBannerController) {
                    return Visibility(
                      visible: homeBannerController.inProgress == false,
                      replacement: const CenterCircularProgressIndicator(),
                      child: BannerCarousel(
                        bannerList:
                            homeBannerController.bannerListModel.bannerList ??
                                [],
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 16,
                ),
                SectionTitle(
                  title: 'All Categories',
                  onTapSeeAll: () {
                    Get.find<MainBottomNavController>().changeIndex(1);
                  },
                ),
                categoryList,
                SectionTitle(
                  title: 'Trending',
                  onTapSeeAll: () {
                    Get.to(() => const ProductListByRemarkScreen(
                          remark: 'trending',
                        ));
                  },
                ),
                GetBuilder<ProductByRemarkController>(
                    tag: 'trending',
                    builder: (productByRemarkController) {
                      return Visibility(
                        visible: productByRemarkController.inProgress == false,
                        replacement: const CenterCircularProgressIndicator(),
                        child: productList(productByRemarkController
                                .productListModel.productList ??
                            []),
                      );
                    }),
                const SizedBox(
                  height: 8,
                ),
                SectionTitle(
                  title: 'Popular',
                  onTapSeeAll: () {
                    Get.to(() => const ProductListByRemarkScreen(
                          remark: 'popular',
                        ));
                  },
                ),
                GetBuilder<ProductByRemarkController>(
                    tag: 'popular',
                    builder: (productByRemarkController) {
                      return Visibility(
                        visible: productByRemarkController.inProgress == false,
                        replacement: const CenterCircularProgressIndicator(),
                        child: productList(productByRemarkController
                                .productListModel.productList ??
                            []),
                      );
                    }),
                const SizedBox(
                  height: 8,
                ),
                SectionTitle(
                  title: 'Special',
                  onTapSeeAll: () {
                    Get.to(() =>
                        const ProductListByRemarkScreen(remark: 'special'));
                  },
                ),
                GetBuilder<ProductByRemarkController>(
                    tag: 'special',
                    builder: (productByRemarkController) {
                      return Visibility(
                        visible: productByRemarkController.inProgress == false,
                        replacement: const CenterCircularProgressIndicator(),
                        child: productList(productByRemarkController
                                .productListModel.productList ??
                            []),
                      );
                    }),
                const SizedBox(
                  height: 8,
                ),
                SectionTitle(
                  title: 'New',
                  onTapSeeAll: () {
                    Get.to(
                        () => const ProductListByRemarkScreen(remark: 'new'));
                  },
                ),
                GetBuilder<ProductByRemarkController>(
                    tag: 'new',
                    builder: (productByRemarkController) {
                      return Visibility(
                        visible: productByRemarkController.inProgress == false,
                        replacement: const CenterCircularProgressIndicator(),
                        child: productList(productByRemarkController
                                .productListModel.productList ??
                            []),
                      );
                    }),
                const SizedBox(
                  height: 16,
                ),
                SectionTitle(
                    title: 'Top Brands',
                    onTapSeeAll: () {
                      Get.to(() => const BrandScreen());
                    }),
                brandList,
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox get categoryList {
    return SizedBox(
      height: 130,
      child: GetBuilder<CategoryListController>(builder: (categoryController) {
        return Visibility(
          visible: categoryController.inProgress == false,
          replacement: const CenterCircularProgressIndicator(),
          child: ListView.separated(
            itemCount:
                categoryController.categoryListModel.categoryList?.length ?? 0,
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CategoryItemCard(
                category:
                    categoryController.categoryListModel.categoryList![index],
              );
            },
            separatorBuilder: (_, __) {
              return const SizedBox(
                width: 8,
              );
            },
          ),
        );
      }),
    );
  }

  SizedBox get brandList {
    return SizedBox(
      height: 130,
      child: GetBuilder<BrandListController>(builder: (brandListController) {
        return Visibility(
          visible: brandListController.inProgress == false,
          replacement: const CenterCircularProgressIndicator(),
          child: ListView.separated(
            itemCount:
                brandListController.brandListModel.brandList?.length ?? 0,
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return BrandItemCard(
                brand: brandListController.brandListModel.brandList![index],
              );
            },
            separatorBuilder: (_, __) {
              return const SizedBox(
                width: 8,
              );
            },
          ),
        );
      }),
    );
  }

  SizedBox productList(List<ProductModel> productList) {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        itemCount: productList.length,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ProductItemCard(
            product: productList[index],
          );
        },
        separatorBuilder: (_, __) {
          return const SizedBox(
            width: 8,
          );
        },
      ),
    );
  }

  TextFormField get searchTextField {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Search',
        filled: true,
        fillColor: Colors.grey.shade200,
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  AppBar get appBar {
    return AppBar(
      title: Image.asset(AssetsPath.logoNav),
      actions: [
        CircleIconButton(
          onTap: () {
            Get.to(() => ReadProfileScreen());
          },
          iconData: Icons.person,
        ),
        const SizedBox(
          width: 8,
        ),
        CircleIconButton(
          onTap: () {},
          iconData: Icons.call,
        ),
        const SizedBox(
          width: 8,
        ),
        CircleIconButton(
          onTap: () {},
          iconData: Icons.notifications_active_outlined,
        ),
      ],
    );
  }
}
