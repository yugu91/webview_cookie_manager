import 'dart:async';
import 'dart:io';

import 'package:webview_cookie_manager_platform_interface/webview_cookie_manager_platform_interface.dart';

class WebviewCookieManager {
  /// Gets whether there are stored cookies
  Future<bool> hasCookies() async {
    return WebViewCookieManagerPlatform.instance.hasCookies();
  }

  /// Read out all cookies, or all cookies for a [currentUrl] when provided
  Future<List<Cookie>> getCookies(String currentUrl) {
    return WebViewCookieManagerPlatform.instance.getCookies(currentUrl);
  }

  /// Remove cookies with [currentUrl] for IOS and Android
  Future<void> removeCookie(String currentUrl) async {
    return WebViewCookieManagerPlatform.instance.removeCookie(currentUrl);
  }

  /// Remove all cookies
  Future<void> clearCookies() {
    return WebViewCookieManagerPlatform.instance.clearCookies();
  }

  /// Set [cookies] into the web view
  Future<void> setCookies(List<Cookie> cookies) {
    return WebViewCookieManagerPlatform.instance.setCookies(cookies);
  }
}
