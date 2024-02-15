import 'package:crafty_bay/data/models/review_model.dart';
import 'package:crafty_bay/presentation/state_holders/review_list_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/create_review_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewListScreen extends StatefulWidget {
  const ReviewListScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ReviewListScreen> createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends State<ReviewListScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ReviewListController>().getReviewList(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
        backgroundColor: Colors.white,
      ),
      body: GetBuilder<ReviewListController>(builder: (reviewListController) {
        List<ReviewModel>? reviewData =
            reviewListController.reviewListModel.reviewList;
        return Visibility(
          visible: reviewListController.inProgress == false,
          replacement: const CenterCircularProgressIndicator(),
          child: Visibility(
            visible: reviewData != null,
            replacement: const Center(
              child: Text('No Review'),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: reviewData?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Card(
                            surfaceTintColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            const Icon(Icons.person_2_rounded),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(reviewData?[index]
                                                    .profile
                                                    ?.cusName ??
                                                ''),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          Text(
                                              '${reviewData?[index].rating ?? 0}')
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                            reviewData?[index].description ??
                                                ''),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        timeAgo(reviewData?[index].updatedAt ??
                                            '0'),
                                        style: const TextStyle(fontSize: 12),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                totalReviewAndAddReviewSection(
                    reviewData?.length ?? 0, reviewListController)
              ],
            ),
          ),
        );
      }),
    );
  }

  Container totalReviewAndAddReviewSection(
      int totalReview, ReviewListController reviewListController) {
    bool hasReview = reviewListController.hasReview();
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
          Text(
            'Reviews ($totalReview)',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black45,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(shape: const CircleBorder()),
            onPressed: () {
              Get.to(() => CreateReviewScreen(
                    productId: widget.productId,
                    hasReview: hasReview,
                    reviewData: hasReview
                        ? reviewListController.reviewListModel
                            .reviewList![reviewListController.hasReviewIndex]
                        : null,
                  ));
            },
            child: hasReview ? const Icon(Icons.edit) : const Icon(Icons.add),
          )
        ],
      ),
    );
  }

  String timeAgo(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    Duration difference = DateTime.now().difference(dateTime);
    String timeAgo = '';
    if (difference.inDays >= 365) {
      int years = (difference.inDays / 365).floor();
      timeAgo = '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays >= 30) {
      int months = (difference.inDays / 30).floor();
      timeAgo = '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays >= 7) {
      int weeks = (difference.inDays / 7).floor();
      timeAgo = '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays >= 1) {
      timeAgo =
          '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours >= 1) {
      timeAgo =
          '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes >= 1) {
      timeAgo =
          '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      timeAgo = 'Just now';
    }
    return timeAgo;
  }
}
