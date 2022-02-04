## PlatformView test

# Flutter
```
class _MainAppState extends State<MainApp> {
  final String _viewType = "testPlatformView";
  final Map<String, dynamic> _params = {"a": 2, "b": 1};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Platform View'),
      ),
      body: Center(
        child: Platform.isAndroid
            ? AndroidView(
                viewType: _viewType,
                creationParams: _params,
                creationParamsCodec: const StandardMessageCodec(),
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                  Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                },
              )
            : UiKitView(
                viewType: _viewType,
                creationParams: _params,
                creationParamsCodec: const StandardMessageCodec(),
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                  Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                },
              ),
      ),
    );
  }
}
```

# Android
```
class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        flutterEngine.plugins.add(TestPlugin())
    }
}

class TestPlugin : FlutterPlugin {
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        binding.platformViewRegistry.registerViewFactory("testPlatformView", TestFactory())
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    }
}

class TestFactory : PlatformViewFactory(StandardMessageCodec()) {
    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val params: Map<String?, Any?>? = args as Map<String?, Any?>?

        return TestView(context!!,params)
    }
}

class TestView(context: Context, private val params: Map<String?, Any?>?) :
    PlatformView {
    private val tv: TextView = TextView(context)

    override fun getView(): View {
        tv.text = "${params?.get("a")} + ${params?.get("b")}"

        return tv
    }

    override fun dispose() {
    }
}
```

# IOS
```
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    self.registrar(forPlugin: "testPlatformView")!.register(TestFactory(), withId: "testPlatformView")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

class TestFactory: NSObject, FlutterPlatformViewFactory{
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {

        return TestView(frame: frame, arguments: args as! NSDictionary?)
    }

    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

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
```

# Result
![스크린샷 2022-02-04 오후 1 37 40](https://user-images.githubusercontent.com/71013471/152472586-6c56798c-a011-42bb-a99c-ce78ae1210aa.png)