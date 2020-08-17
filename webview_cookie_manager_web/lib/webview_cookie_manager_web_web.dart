import 'dart:async';

import 'dart:io';
import 'dart:html';

// import 'dart:ui';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:webview_cookie_manager_platform_interface/webview_cookie_manager_platform_interface.dart';

/// A web implementation of the WebviewCookieManagerWeb plugin.
class WebviewCookieManagerWebWebPlugin extends WebViewCookieManagerPlatform {
  static void registerWith(Registrar registrar) {
    WebViewCookieManagerPlatform.instance = WebviewCookieManagerWebWebPlugin();
  }

  @override
  Future<bool> hasCookies() async {
    document.cookie = "value=2value;";
    String cookies = document.cookie;
    print("WEB: $cookies");
    return null;
  }

  @override
  Future<void> clearCookies() {
    print("Web ClearCookies");

    throw UnimplementedError('ClearCookies() has not been implemented.');
  }

  @override
  Future<List<Cookie>> getCookies(String currentUrl) {
    print("Web getCookies");
    throw UnimplementedError('getCookies() has not been implemented.');
  }

  @override
  Future<void> setCookies(List<Cookie> cookies) {
    print("Web setCookies");
    throw UnimplementedError('setCookies() has not been implemented.');
  }

  @override
  Future<void> removeCookie(String currentUrl) async {
    print("Web removeCookie");
    throw UnimplementedError('removeCookie() has not been implemented.');
  }
}
