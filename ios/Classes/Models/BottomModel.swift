class BottomModel: NSObject {
    
    var adId: String?
    
    // 整个view背景色
    var bottomViewBGColor: String = ""
    // logo资源
    var logoImageName: String = ""
    // 文本内容
    var text: String = ""
    // 文本字体颜色
    var textColor: String = ""
    
    
    // bottomView总高度
    var bottomHeight: Float = 0
    // logo上边距
    var logoImageMarginTop: Float = 0
    // logo宽
    var logoImageWidth: Float = 0
    // logo高
    var logoImageHeight: Float = 0
    // 文本上边距
    var textMarginTop: Float = 0
    // 文本字体大小
    var textFont: Float = 0
    
    init(adConfig: [String: Any]) {
        super.init()
        if adConfig.keys.contains("adId"), let value = adConfig["adId"] {
            adId = value as? String
        }
        if adConfig.keys.contains("bottomViewBGColor"), let value = adConfig["bottomViewBGColor"] {
            bottomViewBGColor = value as? String ?? ""
        }
        if adConfig.keys.contains("logoImageName"), let value = adConfig["logoImageName"] {
            logoImageName = value as? String ?? ""
        }
        if adConfig.keys.contains("text"), let value = adConfig["text"] {
            text = value as? String ?? ""
        }
        if adConfig.keys.contains("textColor"), let value = adConfig["textColor"] {
            textColor = value as? String ?? ""
        }
        if adConfig.keys.contains("bottomHeight"), let value = adConfig["bottomHeight"] {
            bottomHeight = value as? Float ?? 0
        }
        if adConfig.keys.contains("logoImageMarginTop"), let value = adConfig["logoImageMarginTop"] {
            logoImageMarginTop = value as? Float ?? 0
        }
        if adConfig.keys.contains("logoImageWidth"), let value = adConfig["logoImageWidth"] {
            logoImageWidth = value as? Float ?? 0
        }
        if adConfig.keys.contains("logoImageHeight"), let value = adConfig["logoImageHeight"] {
            logoImageHeight = value as? Float ?? 0
        }
        if adConfig.keys.contains("textMarginTop"), let value = adConfig["textMarginTop"] {
            textMarginTop = value as? Float ?? 0
        }
        if adConfig.keys.contains("textFont"), let value = adConfig["textFont"] {
            textFont = value as? Float ?? 0
        }
    }
}

extension BottomModel {
    
    /// 是否配置底部logo
    func isNeedBottom() -> Bool {
        return bottomHeight > 0
    }
}
