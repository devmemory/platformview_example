import Flutter
import UIKit

class TestView: NSObject, FlutterPlatformView{
    private var _view: UIView
    private var params: NSDictionary?
    
    init(frame: CGRect,arguments args: NSDictionary?) {
        _view = UIView()
        
        self.params = args
        
        super.init()
        
        createNativeView(view: _view)
    }
    
    func view() -> UIView{
        print("swift view")
        return _view
    }
    
    func createNativeView(view _view: UIView){

        let nativeLabel = UILabel()
        nativeLabel.text = "\(params!["a"]!) + \(params!["b"]!)"
        nativeLabel.textColor = UIColor.black
        nativeLabel.textAlignment = .left
        nativeLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        _view.addSubview(nativeLabel)
    }
}
