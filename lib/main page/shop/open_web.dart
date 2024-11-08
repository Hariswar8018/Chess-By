import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Open extends StatefulWidget {
  String str;String s3;
  Open({super.key, required this.str,required this.s3});

  @override
  State<Open> createState() => _OpenState();
}

class _OpenState extends State<Open> {
  late InAppWebViewController _webViewController;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
  }

  DateTime? _lastPressedAt;
  int c = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0), // Increased height to accommodate the progress bar
        child: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_sharp),
          ),
          title: Text(widget.s3),
          actions: [
            IconButton(
                onPressed: () {
                  _webViewController.reload();
                },
                icon: Icon(Icons.refresh)),
            SizedBox(width: 3)
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(2.0), // Progress bar height
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.black,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
            image: DecorationImage(image: AssetImage("assets/logo.png"))),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(widget.str))),
        onWebViewCreated: (InAppWebViewController controller) {
          _webViewController = controller;
        },
        onLoadStart: (InAppWebViewController controller, WebUri? url) {
          setState(() {
            progress = 0.0; // Reset progress when starting a new page load
          });
        },
        onProgressChanged: (InAppWebViewController controller, int progressValue) {
          setState(() {
            progress = progressValue / 100.0; // Convert to a value between 0.0 and 1.0
          });
        },
        onLoadStop: (InAppWebViewController controller, WebUri? url) async {
          setState(() {
            progress = 1.0; // Set progress to 100% when page is fully loaded
          });
        },
      ),
    );
  }
}
