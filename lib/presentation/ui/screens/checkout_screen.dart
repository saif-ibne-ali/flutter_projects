import 'package:crafty_bay/presentation/state_holders/create_invoice_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/payment_webview_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CreateInvoiceController>().createInvoice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: GetBuilder<CreateInvoiceController>(
          builder: (createInvoiceController) {
        if (createInvoiceController.inProgress == true) {
          return const CenterCircularProgressIndicator();
        }
        final invoiceWrapper =
            createInvoiceController.paymentMethodList.data?.first;
        return Visibility(
          visible: invoiceWrapper != null,
          replacement: const Center(
            child: Text('Add some product to the cart first'),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Payable: ${invoiceWrapper?.payable ?? ''}'),
                  Text('VAT: ${invoiceWrapper?.vat ?? ''}'),
                  Text('Total: ${invoiceWrapper?.total ?? ''}'),
                  ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: invoiceWrapper?.paymentMethodList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Get.to(() => PaymentWebViewScreen(
                              url: invoiceWrapper!.paymentMethodList![index]
                                  .redirectGatewayURL!));
                        },
                        leading: Image.network(
                            invoiceWrapper?.paymentMethodList![index].logo ??
                                ''),
                        trailing: const Icon(Icons.arrow_forward_rounded),
                        title: Text(
                            invoiceWrapper?.paymentMethodList![index].name ??
                                ''),
                      );
                    },
                    separatorBuilder: (_, __) => const Divider(),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
