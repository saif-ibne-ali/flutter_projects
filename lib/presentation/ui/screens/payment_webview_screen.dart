
import 'package:crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewScreen extends StatefulWidget {
  const PaymentWebViewScreen({super.key, required this.url});

  final String url;

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late WebViewController _webViewController;
  late String _currentUrl;

  @override
  void initState() {
    super.initState();
    _currentUrl = widget.url;
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            setState(() {});
            _currentUrl = url;
          },
          onPageFinished: (String url) {
            setState(() {});
            _currentUrl = url;
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: WebViewWidget(
        controller: _webViewController,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example: Close WebView and show snackbar when FAB is pressed
          closeWebViewAndShowSnackbar();
        },
        child: const Icon(Icons.close),
      ),
    );
  }

  String extractEndpoint(String url) {
    RegExp regex = RegExp(r'/api/(\w+)\?');
    Match? match = regex.firstMatch(url);
    if (match != null) {
      return match.group(1)!;
    } else {
      return '';
    }
  }

  void closeWebViewAndShowSnackbar() {
    _webViewController.clearCache();
    Get.offAll(()=> const MainBottomNavScreen());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(extractEndpoint(_currentUrl)),
      ),
    );
  }
}
