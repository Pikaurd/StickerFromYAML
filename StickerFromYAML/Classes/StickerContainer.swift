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
    public var lottieView: LOTAnimationView { get { return lottieContainer.lottieView } }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public init(animationUrl: URL, configUrl: URL, interpreter: ExpressionInterpreter? = .none) {
        super.init(frame: .zero)
        
        let yamlString = try! String(contentsOf: configUrl)
        let yaml = try! Yaml.load(yamlString)
        
        config = yaml
        
        let animationLayout = Layout.fromYaml(v: yaml["animation container"]["layout"])!
        let labelLayout = Layout.fromYaml(v: yaml["label container"]["layout"])!
        
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
                
        labelContainer.fillLabels(by: config["label container"]["labels"])
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
        let v = labelContainer.labelView()
        v.frame = frame
        v.transform = transform
        return v
    }
    
}
