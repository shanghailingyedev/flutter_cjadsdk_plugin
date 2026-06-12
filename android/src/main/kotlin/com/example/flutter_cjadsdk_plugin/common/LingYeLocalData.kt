package com.example.flutter_cjadsdk_plugin.common

import android.view.View
import java.util.concurrent.ConcurrentHashMap

class LingYeLocalData {

    private val adViewMap: MutableMap<String, View> = ConcurrentHashMap()

    companion object {
        @Volatile
        private var instance: LingYeLocalData? = null

        fun getInstance(): LingYeLocalData {
            return instance ?: synchronized(this) {
                instance ?: LingYeLocalData().also { instance = it }
            }
        }
    }

    // 根据信息流ID保存view
    fun addNativeAdForId(nativeId: String, view: View) {
        if (nativeId.isNotBlank()) {
            adViewMap[nativeId] = view
        }
    }

    fun getAdView(nativeId: String): View? {
        return adViewMap[nativeId]
    }

    fun removeNativeAdForId(nativeId: String): Boolean {
        return adViewMap.remove(nativeId) != null
    }

    fun clearAllNativeView() {
        adViewMap.clear()
    }
}