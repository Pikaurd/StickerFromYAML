//
//  StickerContainer.swift
//  StickerFromYAML
//
//  Created by hirochin on 09/03/2018.
//

import UIKit
import Lottie
import Yaml
import JavaScriptCore


public class StickerContainer: UIView {
    
    var lottieContainer: AnimationContainerView!
    var labelContainer: LabelContainerView!
    var config: Yaml!
    
    public var stickerName = ""
    
    public var lottieView: LOTAnimationView? { get { return lottieContainer?.lottieView } }
    public var animationContainerView: UIView { get { return lottieContainer.centerView } }
    
    public init() {
        super.init(frame: .zero)
        config = Yaml(stringLiteral: "")
        setup()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        config = Yaml(stringLiteral: "")
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config = Yaml(stringLiteral: "")
        setup()
    }
    
    public init(animationUrl: URL, configUrl: URL, interpreter: ExpressionInterpreter? = .none) {
        super.init(frame: .zero)
        
        let yamlString = try! String(contentsOf: configUrl)
        let yaml = try! Yaml.load(yamlString)
        
        config = yaml
        
        let animationLayout = Layout.fromYaml(v: yaml["animation container"]["layout"]) ?? Layout.zero()
        let labelLayout = Layout.fromYaml(v: yaml["label container"]["layout"]) ?? Layout.zero()
        
        setup(animationLayout: animationLayout, labelLayout: labelLayout, interpreter: interpreter)
        lottieContainer.replaceAnimation(animationUrl: animationUrl)
    }
    
    private func setup(animationLayout: Layout = Layout.zero(), labelLayout: Layout = Layout.zero(), interpreter: ExpressionInterpreter? = .none) -> () {
        lottieContainer = AnimationContainerView(frame: frame, layout: animationLayout)
        labelContainer = LabelContainerView(frame: frame, layout: labelLayout, interpreter: interpreter)
        
        lottieContainer.isUserInteractionEnabled = false
        labelContainer.isUserInteractionEnabled = false
        
        lottieContainer.frame = bounds
        labelContainer.frame = bounds
        
        lottieContainer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        labelContainer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(lottieContainer)
        addSubview(labelContainer)
                
        labelContainer.fillLabels(by: config["label container"])
    }

    public func loadLottie(url: URL) -> () {
        lottieContainer.replaceAnimation(animationUrl: url)
    }
    
    public func getLabelLayer() -> CALayer {
        let resultLayer = labelContainer.animationLayer()
        resultLayer.frame = frame
        resultLayer.setAffineTransform(transform)
        
        return resultLayer
    }
    
    public func getLabelView() -> UIView {
        let v = labelContainer.labelView(container: self)
        v.frame = frame
        v.transform = CGAffineTransform(rotationAngle: transform.rotation)
        return v
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        labelContainer.layoutSubviews()
    }
    
}
