class LingYeBottomModel {

    var adId: String? = null

    // 整个view背景色
    var bottomViewBGColor: String = ""
    // logo资源
    var logoImageName: String = ""
    // 文本内容
    var text: String = ""
    // 文本字体颜色
    var textColor: String = ""


    // bottomView总高度
    var bottomHeight:  Double = 0.0
    // logo上边距
    var logoImageMarginTop: Double = 0.0
    // logo宽
    var logoImageWidth: Double = 0.0
    // logo高
    var logoImageHeight: Double = 0.0
    // 文本上边距
    var textMarginTop: Double = 0.0
    // 文本字体大小
    var textFont: Double = 0.0

    fun setupAdConfig(adConfig:  Map<String, Any>) {

        if (adConfig.keys.contains("adId")) {
            adId = adConfig["adId"] as? String
        }

        if (adConfig.keys.contains("bottomViewBGColor")) {
            bottomViewBGColor = adConfig["bottomViewBGColor"].toString()
        }
        if (adConfig.keys.contains("logoImageName")) {
            logoImageName = adConfig["logoImageName"].toString()
        }
        if (adConfig.keys.contains("text")) {
            text = adConfig["text"].toString()
        }
        if (adConfig.keys.contains("textColor")) {
            textColor = adConfig["textColor"].toString()
        }
        if (adConfig.keys.contains("bottomHeight")) {
            bottomHeight = adConfig["bottomHeight"] as Double
        }
        if (adConfig.keys.contains("logoImageMarginTop")) {
            logoImageMarginTop = adConfig["logoImageMarginTop"]  as Double
        }
        if (adConfig.keys.contains("logoImageWidth")) {
            logoImageWidth = adConfig["logoImageWidth"] as Double
        }
        if (adConfig.keys.contains("logoImageHeight")) {
            logoImageHeight = adConfig["logoImageHeight"] as Double
        }
        if (adConfig.keys.contains("textMarginTop")) {
            textMarginTop = adConfig["textMarginTop"] as Double
        }
        if (adConfig.keys.contains("textFont")) {
            textFont = adConfig["textFont"] as Double
        }
    }

    fun isNeedBottom(): Boolean {
        return bottomHeight > 0
    }
}
