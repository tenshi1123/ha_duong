import 'package:flutter/material.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({super.key, required this.link, required this.title});
  final String link;
  final String title;
  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(buildPreviewUrl(link)));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff273D8C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        title: Text(
          title,
          style: defaultText18B.copyWith(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: Colors.white),
            onPressed: () {
              launchUrl(Uri.parse(link));
            },
          ),
        ],
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}

String buildPreviewUrl(String url) {
  final officeExts = ['xlsx', 'xlsm', 'xls', 'docx', 'docm', 'pptx', 'pptm'];
  final pdfExts = ['pdf'];

  // Lấy phần mở rộng file
  final uri = Uri.parse(url);
  final path = uri.path.toLowerCase();
  final ext = path.split('.').last;

  if (officeExts.contains(ext)) {
    return 'https://view.officeapps.live.com/op/embed.aspx?src=$url';
  } else if (pdfExts.contains(ext)) {
    return 'https://drive.google.com/viewerng/viewer?embedded=true&url=$url';
  } else {
    return url;
  }
}
