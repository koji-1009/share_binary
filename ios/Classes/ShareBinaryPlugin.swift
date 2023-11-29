import Flutter
import UIKit

public class ShareBinaryPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.dr1009.app/share_binary", binaryMessenger: registrar.messenger())
        let instance = ShareBinaryPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any] else {
            result(FlutterError(code: "InvalidArgs", message: "Missing arguments", details: "Expected valid arguments."))
            return
        }
        
        switch call.method {
        case "shareBinary":
            let bytesTypedData = args["bytes"] as! FlutterStandardTypedData
            let filename = args["filename"] as! String
            
            let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            let cacheFileURL = cacheDir.appendingPathComponent(filename)
            try? bytesTypedData.data.write(to: cacheFileURL)
            
            let viewController = UIApplication.shared.delegate?.window??.rootViewController
            let shareSheet = UIActivityViewController(activityItems: [cacheFileURL], applicationActivities: nil)
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                // only ipad
                let screenSize = viewController?.view.bounds ?? .zero
                if let popoverController = shareSheet.popoverPresentationController {
                    popoverController.sourceView = viewController?.view
                    popoverController.sourceRect = CGRect(
                        x: screenSize.size.width / 2,
                        y: screenSize.size.height - 20,
                        width: 0,
                        height: 0
                    )
                }
            }
            viewController?.present(shareSheet, animated: true, completion: nil)
            
            result(nil)
        case "shareUri":
            let uriString = args["uri"] as! String
            guard let uri = URL(string: uriString) else {
                result(FlutterError(code: "InvalidArgs", message: "URI is invalid", details: "uri must be able to be parsed in swift"))
                return
            }
            
            let viewController = UIApplication.shared.delegate?.window??.rootViewController
            let shareSheet = UIActivityViewController(activityItems: [uri], applicationActivities: nil)

            if UIDevice.current.userInterfaceIdiom == .pad {
                // only ipad
                let screenSize = viewController?.view.bounds ?? .zero
                if let popoverController = shareSheet.popoverPresentationController {
                    popoverController.sourceView = viewController?.view
                    popoverController.sourceRect = CGRect(
                        x: screenSize.size.width / 2,
                        y: screenSize.size.height - 20,
                        width: 0,
                        height: 0
                    )
                }
            }
            viewController?.present(shareSheet, animated: true, completion: nil)
            
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
