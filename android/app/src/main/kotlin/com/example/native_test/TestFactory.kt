package com.example.native_test

import android.content.Context
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class TestFactory : PlatformViewFactory(StandardMessageCodec()) {
    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val params: Map<String?, Any?>? = args as Map<String?, Any?>?

        return TestView(context!!,params)
    }
}