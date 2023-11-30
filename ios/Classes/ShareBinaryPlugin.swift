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
            guard let bytesTypedData = args["bytes"] as? FlutterStandardTypedData else {
                result(FlutterError(code: "InvalidArgs", message: "bytes is invalid", details: "bytes must be able to be parsed in swift"))
                return
            }
            guard let filename = args["filename"] as? String else {
                result(FlutterError(code: "InvalidArgs", message: "filename is invalid", details: "filename must be able to be parsed in swift"))
                return
            }
            
            let fileManager = FileManager.default
            let urls = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
            let cachesDirectoryUrl = urls[0]
            
            let directoryUrl = cachesDirectoryUrl.appendingPathComponent("share_binary", isDirectory: true)
            let direcotryPath = directoryUrl.path
            
            if fileManager.fileExists(atPath: direcotryPath) {
                try? fileManager.removeItem(atPath: direcotryPath)
            }
            try? fileManager.createDirectory(atPath: directoryUrl.path, withIntermediateDirectories: true)
            
            let fileUrl = directoryUrl.appendingPathComponent(filename)
            let filePath = fileUrl.path
            fileManager.createFile(atPath: filePath, contents: bytesTypedData.data)
            
            showShareSheet(uri: fileUrl)
            
            result(nil)
        case "shareUri":
            let uriString = args["uri"] as! String
            guard let uri = URL(string: uriString) else {
                result(FlutterError(code: "InvalidArgs", message: "URI is invalid", details: "uri must be able to be parsed in swift"))
                return
            }
            
            showShareSheet(uri: uri)
            
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func showShareSheet(uri: URL) {
        guard let rootViewController = UIApplication.shared.delegate?.window??.rootViewController,
              let view = rootViewController.view else {
            return
        }
        
        let documentInteractionController = UIDocumentInteractionController(url: uri)
        if UIDevice.current.userInterfaceIdiom == .phone {
            documentInteractionController.presentOptionsMenu(
                from: view.bounds,
                in: view,
                animated: true
            )
        } else {
            documentInteractionController.presentOptionsMenu(
                from: CGRect(
                    x: view.bounds.size.width / 2,
                    y: view.bounds.size.height - 20,
                    width: 0,
                    height: 0
                ),
                in: view,
                animated: true
            )
        }
    }
}
