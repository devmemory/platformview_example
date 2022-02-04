package com.example.native_test

import android.content.Context
import android.view.View
import android.widget.TextView
import io.flutter.plugin.platform.PlatformView

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