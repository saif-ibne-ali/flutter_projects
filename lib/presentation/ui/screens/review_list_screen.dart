import 'package:crafty_bay/data/models/review_model.dart';
import 'package:crafty_bay/presentation/state_holders/review_list_controller.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            GetBuilder<ReviewListController>(builder: (reviewListController) {
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
              child: ListView.builder(
                  itemCount: reviewData!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.person_2_rounded),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(reviewData[index].profile!.cusName!)
                              ],
                            ),
                            Text(reviewData[index].description!)
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          );
        }),
      ),
    );
  }
}
