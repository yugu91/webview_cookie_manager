import Flutter
import UIKit
import WebKit

public class SwiftWebviewCookieManagerPlugin: NSObject, FlutterPlugin {
    @available(iOS 11.0, *)
    static var httpCookieStore: WKHTTPCookieStore?
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    if #available(iOS 11.0, *) {
        httpCookieStore = WKWebsiteDataStore.default().httpCookieStore
    }
    
    let channel = FlutterMethodChannel(name: "webview_cookie_manager", binaryMessenger: registrar.messenger())
    let instance = SwiftWebviewCookieManagerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
        case "getCookies":
            let arguments = call.arguments as! NSDictionary
            let url = arguments["url"] as? String
            if #available(iOS 11.0, *) {
                SwiftWebviewCookieManagerPlugin.getCookies(url: url, result: result)
            }else{
                result([]);
            }
            break
        case "setCookies":
            let cookies = call.arguments as! Array<NSDictionary>
            if #available(iOS 11.0, *) {
                SwiftWebviewCookieManagerPlugin.setCookies(cookies: cookies, result: result)
            }else{
                result(true);
            }
            break
        case "hasCookies":
            if #available(iOS 11.0, *) {
                SwiftWebviewCookieManagerPlugin.hasCookies(result: result)
            }else{
                result(false);
            }
            break
        case "clearCookies":
            if #available(iOS 11.0, *) {
                SwiftWebviewCookieManagerPlugin.clearCookies(result: result)
            }else{
                result(nil);
            }
            break
        default:
            result(FlutterMethodNotImplemented)
            break
    }
  }
    
    @available(iOS 11.0, *)
    public static func setCookies(cookies: Array<NSDictionary>, result: @escaping FlutterResult) {
        for cookie in cookies {
            _setCookie(cookie: cookie, result: result)
        }
        
    }
    
    @available(iOS 11.0, *)
    public static func clearCookies(result: @escaping FlutterResult) {
        httpCookieStore!.getAllCookies { (cookies) in
                for cookie in cookies {
                  httpCookieStore!.delete(cookie, completionHandler: nil)
                }
            result(nil)
        }
    }
    
    @available(iOS 11.0, *)
    public static func hasCookies(result: @escaping FlutterResult) {
        httpCookieStore!.getAllCookies { (cookies) in
            result(!cookies.isEmpty)
        }
    }
    
    @available(iOS 11.0, *)
    private static func _setCookie(cookie: NSDictionary, result: @escaping FlutterResult) {
        let expiresDate = cookie["expires"] as? Double
        let isSecure = cookie["secure"] as? Bool
        let isHttpOnly = cookie["httpOnly"] as? Bool
        
        var properties: [HTTPCookiePropertyKey: Any] = [:]
        if let name = cookie["name"] as? String,
           let value = cookie["value"] as? String,
           let domain = cookie["domain"] as? String {
            properties[.name] = name
            properties[.value] = value
            properties[.domain] = domain
        }else{
            print(cookie);
            print("Cookies set error,\"name value domain\" not be null");
            return;
        }
        
        properties[.path] = cookie["path"] as? String ?? "/"
        if expiresDate != nil {
            properties[.expires] = Date(timeIntervalSince1970: expiresDate!)
        }
        if isSecure != nil && isSecure! {
            properties[.secure] = "TRUE"
        }
        if isHttpOnly != nil && isHttpOnly! {
            properties[.init("HttpOnly")] = "YES"
        }
        
        let cookie = HTTPCookie(properties: properties)!
        
        httpCookieStore!.setCookie(cookie, completionHandler: {() in
            result(true)
        })
    }
    
    @available(iOS 11.0, *)
    public static func getCookies(url: String?, result: @escaping FlutterResult) {
        let cookieList: NSMutableArray = NSMutableArray()
        httpCookieStore!.getAllCookies { (cookies) in
            for cookie in cookies {
                if url == nil {
                    cookieList.add(_cookieToDictionary(cookie: cookie))
                }
                else if cookie.domain.contains(URL(string: url!)!.host!) {
                    cookieList.add(_cookieToDictionary(cookie: cookie))
                }
            }
            result(cookieList)
        }
    }
    
    public static func  _cookieToDictionary(cookie: HTTPCookie) -> NSDictionary {
        let result : NSMutableDictionary =  NSMutableDictionary()
        
        result.setValue(cookie.name, forKey: "name")
        result.setValue(cookie.value, forKey: "value")
        result.setValue(cookie.domain, forKey: "domain")
        result.setValue(cookie.path, forKey: "path")
        result.setValue(cookie.isSecure, forKey: "secure")
        result.setValue(cookie.isHTTPOnly, forKey: "httpOnly")
        
        if cookie.expiresDate != nil {
            let expiredDate = cookie.expiresDate?.timeIntervalSince1970
            result.setValue(Int(expiredDate!), forKey: "expires")
        }
        
        return result;
    }
}
