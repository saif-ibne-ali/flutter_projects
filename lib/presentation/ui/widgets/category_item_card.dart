import 'package:crafty_bay/data/models/category.dart';
import 'package:crafty_bay/presentation/ui/screens/product_list_by_category_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryItemCard extends StatelessWidget {
  const CategoryItemCard({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductListByCategoryScreen(
              category: category.categoryName ?? '',
              categoryId: category.id,
            ));
      },
      child: Column(
        children: [
          Card(
            elevation: 0,
            color: AppColors.primaryColor.withOpacity(0.1),
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.network(
                  category.categoryImg ?? AssetsPath.dummyShoeImageJpg,
                  width: 40,
                  height: 40,
                )),
          ),
          Text(
            category.categoryName ?? '',
            style: const TextStyle(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}