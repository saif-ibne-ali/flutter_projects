import 'package:crafty_bay/data/models/review_model.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/create_review_controller.dart';
import 'package:crafty_bay/presentation/state_holders/review_list_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen(
      {Key? key,
      this.reviewData,
      required this.productId,
      required this.hasReview})
      : super(key: key);

  final ReviewModel? reviewData;
  final int productId;
  final bool hasReview;

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  TextEditingController _reviewTEController = TextEditingController();
  int _rating = 0; // Variable to hold the selected rating

  @override
  void initState() {
    super.initState();
    if (widget.hasReview) {
      _reviewTEController =
          TextEditingController(text: widget.reviewData!.description);
      _rating = int.parse(widget.reviewData!.rating ?? '0');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.hasReview
            ? const Text('Edit Review')
            : const Text('Create Review'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 32,
              ),
              Text(
                'Hi! ${widget.hasReview ? widget.reviewData!.profile!.cusName : AuthController.profile!.cusName}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Give Your Rating :',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        // Set the rating based on the selected star
                        _rating = index + 1;
                      });
                    },
                    child: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      color: Colors.orange,
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              const Text(
                'Give Your Reviews :',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _reviewTEController,
                maxLines: 10,
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                  width: double.infinity,
                  child: GetBuilder<CreateReviewController>(
                    builder: (createReviewController) {
                      return Visibility(
                        visible: createReviewController.inProgress == false,
                        replacement: const CenterCircularProgressIndicator(),
                        child: ElevatedButton(
                            onPressed: () async {
                              final response = await createReviewController.createReview(ReviewModel(
                                  description: _reviewTEController.text.trim(),
                                  productId: widget.productId,
                                  rating: _rating.toString()));
                              if(response){
                                Get.find<ReviewListController>().getReviewList(widget.productId);
                              }
                              Get.back();
                            },
                            child: const Text('Submit')),
                      );
                    }
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
