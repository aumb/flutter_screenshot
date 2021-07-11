import Cocoa
import FlutterMacOS

public class FlutterScreenshotPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_screenshot", binaryMessenger: registrar.messenger)
    let instance = FlutterScreenshotPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getScreenshot":
      result(takeScreenshot())
    default:
      result(FlutterMethodNotImplemented)
    }
  }

    public func takeScreenshot() -> Data? {
        let displayID = CGMainDisplayID()
        let imageRef = CGDisplayCreateImage(displayID)
        let bitmapRep = NSBitmapImageRep(cgImage: imageRef!)
        let data = bitmapRep.representation(using: NSBitmapImageRep.FileType.png, properties: [:])!
        
        return data
    }
    
}
