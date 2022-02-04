import Flutter

class TestFactory: NSObject, FlutterPlatformViewFactory{
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        
        return TestView(frame: frame, arguments: args as! NSDictionary?)
    }
    
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
