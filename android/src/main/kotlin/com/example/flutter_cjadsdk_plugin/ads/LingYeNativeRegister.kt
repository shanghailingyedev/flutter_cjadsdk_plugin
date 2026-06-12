package com.example.flutter_cjadsdk_plugin.common

import LingYeAdSdkMethodNames
import android.util.Log
import com.example.flutter_cjadsdk_plugin.ads.LingYeIconFactory
//import com.example.flutter_cjadsdk_plugin.ads.LingYeIconFactory
import com.example.flutter_cjadsdk_plugin.ads.LingYeNativeFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.plugin.common.StandardMessageCodec

class LingYeNativeRegister {

    companion object {
        @Volatile
        private var instance: LingYeNativeRegister? = null
        fun getInstance(): LingYeNativeRegister {
            return instance ?: synchronized(this) {
                instance ?: LingYeNativeRegister().also { instance = it }
            }
        }
    }

    fun initHandler(binding: FlutterPluginBinding) {
        val platformViewRegistry = binding.platformViewRegistry
        val binaryMessenger = binding.binaryMessenger
        platformViewRegistry.registerViewFactory(
            LingYeAdSdkMethodNames.nativeContentRegisterKey,
            LingYeNativeFactory.NativeFactory(binaryMessenger, StandardMessageCodec.INSTANCE)
        )

        platformViewRegistry.registerViewFactory(
            LingYeAdSdkMethodNames.iconContentRegisterKey,
            LingYeIconFactory.NativeFactory(binaryMessenger, StandardMessageCodec.INSTANCE)
        )
    }
}

