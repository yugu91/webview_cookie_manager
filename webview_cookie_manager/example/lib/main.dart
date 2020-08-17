import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final cookieManager = WebviewCookieManager();

  final String _url = 'https://flutter.dev/';
  final String cookieValue = 'some-cookie-value';
  final String domain = 'youtube.com';
  final String cookieName = 'some_cookie_name';

  @override
  void initState() {
    super.initState();
    // cookieManager.clearCookies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () async {
            print(await cookieManager.hasCookies());
          }),
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: EasyWebView(
              src: _url,
              width: 450,
              onLoaded: () async {
                print(await cookieManager.hasCookies());
              })),
    );
  }
}
