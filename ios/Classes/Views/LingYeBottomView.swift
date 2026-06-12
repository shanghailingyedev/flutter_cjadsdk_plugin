class LingYeBottomView: UIView {
    
    var imageView: UIImageView = UIImageView()
    var textLabel: UILabel = UILabel()
    
    init(bottomModel: BottomModel?) {
        super.init(frame: .zero)
        guard let bottomModel = bottomModel, bottomModel.isNeedBottom() else {
            LingYeTools.shared.lyLog(msg: "无logo配置")
            return
        }
        frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: CGFloat(bottomModel.bottomHeight))
        backgroundColor = LingYeTools.shared.lyHexString(hexString: bottomModel.bottomViewBGColor)
        if bottomModel.logoImageName.count > 0 {
            imageView.image = UIImage.init(named: bottomModel.logoImageName)
            imageView.frame = CGRect(x: 0, y: Int(bottomModel.logoImageMarginTop), width: Int(bottomModel.logoImageWidth), height: Int(bottomModel.logoImageHeight))
            imageView.backgroundColor = .red
            imageView.center.x = center.x
        }
        if bottomModel.text.count > 0 {
            textLabel.numberOfLines = 0
            textLabel.text = bottomModel.text
            textLabel.font = UIFont.systemFont(ofSize: CGFloat(bottomModel.textFont))
            textLabel.textColor = LingYeTools.shared.lyHexString(hexString: bottomModel.textColor)
            textLabel.textAlignment = .center
            textLabel.frame = CGRect(x: 0, y: CGFloat(bottomModel.logoImageMarginTop + bottomModel.logoImageHeight + bottomModel.textMarginTop), width: UIScreen.main.bounds.size.width, height: CGFloat(bottomModel.textFont))
            textLabel.backgroundColor = .black;
        }
        
        NSLog("----imageView:%@", imageView)
        NSLog("-----textLabel--%@", textLabel)
        addSubview(imageView)
        addSubview(textLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
