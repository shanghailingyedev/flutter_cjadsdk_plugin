import android.app.Activity
import android.content.Context
import android.graphics.Point
import android.os.Build
import android.os.Looper
import android.view.ViewGroup
import android.widget.FrameLayout
import com.example.flutter_cjadsdk_plugin.Views.LingYeIconView
import java.lang.ref.WeakReference

class LingYeTools {

    companion object {
        var activityWeakRef: WeakReference<Activity>? = null
        var iconContentView: WeakReference<LingYeIconView>? = null

        fun setActivityWeakRef(activity: Activity?){
            activityWeakRef = activity?.let { WeakReference(it) }
        }

        fun setIconContentView(content: LingYeIconView?){
            iconContentView = content?.let { WeakReference(it) }
        }

        fun getActivity(): Activity? {
            return  activityWeakRef?.get()
        }

        fun getIconContentView(): LingYeIconView? {
            return iconContentView?.get()
        }

        fun getScreenSize(): Point {
            val activity = getActivity()
            val size = Point()
            activity?.let {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                    val metrics = it.windowManager.currentWindowMetrics
                    size.x = metrics.bounds.width()
                    size.y = metrics.bounds.height()
                } else {
                    @Suppress("DEPRECATION")
                    val display = it.windowManager.defaultDisplay
                    @Suppress("DEPRECATION")
                    display.getRealSize(size)
                }
                return size
            }
            return size
        }

        fun getApplicationContext(): Context? {
            return try {
                // Priority 1: Get from Activity (if alive)
                getActivity()?.applicationContext
                    ?: // Priority 2: Fallback (if no Activity, use system Context - rare)
                    getSystemApplicationContext()
            } catch (t: Throwable) {
                t.printStackTrace()
                null
            }
        }

        private fun getSystemApplicationContext(): Context? {
            return try {
                // Get ApplicationContext via system class (avoids static Context leaks)
                Class.forName("android.app.ActivityThread")
                    .getMethod("currentApplication")
                    .invoke(null) as? Context
            } catch (t: Throwable) {
                t.printStackTrace()
                null
            }
        }

        fun runOnThread(runnable: Runnable) {
            try {
                if (Looper.getMainLooper() == Looper.myLooper()) {
                    runnable.run()
                } else {
                    // 使用主线程 Handler 是最稳妥且统一的做法
                    android.os.Handler(Looper.getMainLooper()).post(runnable)
                }
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }

}