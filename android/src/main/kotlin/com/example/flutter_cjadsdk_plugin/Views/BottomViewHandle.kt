import android.graphics.Color
import android.util.TypedValue
import android.view.Gravity
import android.widget.FrameLayout
import android.widget.ImageView
import android.widget.TextView
import androidx.core.graphics.toColorInt

class BottomViewHandle {

    var content: FrameLayout? = null
    var splashContent: FrameLayout? = null
    var bottomView: FrameLayout? = null
    var imageView: ImageView? = null
    var textLabel: TextView? = null

    fun setupBottom(model: LingYeBottomModel) {
        val activity = LingYeTools.getActivity()
        if (activity != null) {
            content = FrameLayout(activity)
            content?.setBackgroundColor(Color.WHITE)
            splashContent = FrameLayout(activity)
            splashContent?.setBackgroundColor(Color.WHITE)
            bottomView = FrameLayout(activity)
            if (model.bottomViewBGColor.isNotEmpty()) {
                bottomView?.setBackgroundColor(model.bottomViewBGColor.toColorInt())
            }

            val point = LingYeTools.getScreenSize()
            val height = point.y
            val width = point.x


            val contentParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.MATCH_PARENT,
            )
            val splashContentParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                height-model.bottomHeight.toInt()
            )

            val bottomLayoutParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                model.bottomHeight.toInt()
            )
            bottomLayoutParams.gravity = Gravity.BOTTOM
            content?.layoutParams = contentParams
            content?.addView(splashContent, splashContentParams)
            if (model.isNeedBottom()) {
                content?.addView(bottomView,bottomLayoutParams)
            }
            textLabel = TextView(activity)
            textLabel?.text = model.text
            textLabel?.setTextSize(TypedValue.COMPLEX_UNIT_SP, model.textFont.toFloat())
            if (model.textColor.isNotEmpty()) {
                textLabel?.setTextColor(model.textColor.toColorInt())
            }
            textLabel?.gravity = Gravity.CENTER_HORIZONTAL

            val resId: Int = activity.getResources().getIdentifier(
                model.logoImageName,
                "mipmap", activity.getPackageName()
            )

            imageView = ImageView(activity)
            if (resId > 0) {
                imageView?.setImageResource(resId)
            }
            val imageViewLayoutParams = FrameLayout.LayoutParams(
                model.logoImageWidth.toInt(),
                model.logoImageHeight.toInt(),
            )
            imageViewLayoutParams.topMargin = model.logoImageMarginTop.toInt()
            imageViewLayoutParams.leftMargin = ((width - model.logoImageWidth)/2).toInt()

            val textLayoutParams = FrameLayout.LayoutParams(
                width,
                FrameLayout.LayoutParams.WRAP_CONTENT,
            )
            textLayoutParams.topMargin = (model.textMarginTop + model.logoImageMarginTop + model.logoImageHeight).toInt()

            imageView?.layoutParams = imageViewLayoutParams
            textLabel?.layoutParams = textLayoutParams
            bottomView?.addView(textLabel)
            bottomView?.addView(imageView)
        } else {

        }
    }



    fun getWidth(): Int {
        content?.width?.let {
            return it
        }
        return 0
    }

    fun getHeight(): Int {
        content?.height?.let {
            return it
        }
        return 0
    }
}