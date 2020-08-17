#import "WebviewCookieManagerWebPlugin.h"
#if __has_include(<webview_cookie_manager_web/webview_cookie_manager_web-Swift.h>)
#import <webview_cookie_manager_web/webview_cookie_manager_web-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "webview_cookie_manager_web-Swift.h"
#endif

@implementation WebviewCookieManagerWebPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftWebviewCookieManagerWebPlugin registerWithRegistrar:registrar];
}
@end
