import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sibatikgal/app/modules/analisis/controllers/analisis_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AnalisisView extends GetView<AnalisisController> {
  const AnalisisView({super.key});

  @override
  Widget build(BuildContext context) {
    final WebViewController webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(
          Uri.parse('https://huggingface.co/spaces/emst/Visualisasi'));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Analysis',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: WebViewWidget(controller: webViewController),
    );
  }
}
