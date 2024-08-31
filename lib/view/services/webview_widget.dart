import 'dart:io';
import 'package:flutter/material.dart';
import 'package:session_mate/utils/common_methods.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  final String url;
  const WebViewExample({Key? key, required this.url}) : super(key: key);

  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: widget.url,
          onWebResourceError: (WebResourceError webviewerrr) {
            logs("webview_flutter:" + webviewerrr.description);
          },
        ),
      ),
    );
  }
}
