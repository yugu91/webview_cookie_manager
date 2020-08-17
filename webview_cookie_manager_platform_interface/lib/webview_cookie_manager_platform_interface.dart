import 'dart:async';
import 'dart:io';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_webview_cookie_manager.dart';

/// The interface that implementations of url_launcher must implement.
///
/// Platform implementations should extend this class rather than implement it as `url_launcher`
/// does not consider newly added methods to be breaking changes. Extending this class
/// (using `extends`) ensures that the subclass will get the default implementation, while
/// platform implementations that `implements` this interface will be broken by newly added
/// [UrlLauncherPlatform] methods.
abstract class WebViewCookieManagerPlatform extends PlatformInterface {
  /// Constructs a UrlLauncherPlatform.
  WebViewCookieManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static WebViewCookieManagerPlatform _instance =
      MethodChannelWebViewCookieManager();

  static WebViewCookieManagerPlatform get instance => _instance;

  static set instance(WebViewCookieManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> hasCookies() {
    throw UnimplementedError('hasCookies() has not been implemented.');
  }

  Future<void> clearCookies() {
    throw UnimplementedError('clearCookies() has not been implemented.');
  }

  Future<List<Cookie>> getCookies(String currentUrl) {
    throw UnimplementedError('getCookies() has not been implemented.');
    return null;
  }

  Future<void> setCookies(List<Cookie> cookies) {
    throw UnimplementedError('getCookies() has not been implemented.');
  }

  Future<void> removeCookie(String currentUrl) async {
    throw UnimplementedError('getCookies() has not been implemented.');
  }
}
