import Flutter
import UIKit

public class SwiftFlutterScreenshotPlugin: NSObject, FlutterPlugin {
    var controller :FlutterViewController!
    var messenger :FlutterBinaryMessenger
    
    init(controller: FlutterViewController, messenger: FlutterBinaryMessenger) {
        self.controller = controller
        self.messenger = messenger
        super.init()
    }
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_screenshot", binaryMessenger: registrar.messenger())
        let app = UIApplication.shared
        let controller :FlutterViewController = app.delegate!.window!!.rootViewController as! FlutterViewController
        
        let instance = SwiftFlutterScreenshotPlugin(controller: controller,messenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getScreenshot":
            result(takeScreenshot(view:controller.view))
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    public func takeScreenshot(view: UIView) -> Data?{
        let scale :CGFloat = UIScreen.main.scale;
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, scale);
        
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let optionalImage :UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let byesImage = optionalImage?.pngData();
        
        return byesImage
    }
}
