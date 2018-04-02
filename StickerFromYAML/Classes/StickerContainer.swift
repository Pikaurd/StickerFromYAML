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
    public var stickerFrameCont = 30
    public var isActive = false
    public var debugMode = false {
        didSet {
            if debugMode {
                addSubview(debugTouchableAreaView)
            }
            else {
                debugTouchableAreaView.removeFromSuperview()
            }
        }
    }
    
    public var lottieView: LOTAnimationView? { get { return lottieContainer?.lottieView } }
    public var animationContainerView: UIView { get { return lottieContainer.animatedImageView } }
    
    let debugTouchableAreaView = UIView()
    
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
    
    public convenience init(animationUrl: URL?, configUrl: URL, interpreter: ExpressionInterpreter? = .none) {
        self.init(animationUrl: animationUrl, configUrl: configUrl, placeholderImage: .none, interpreter: interpreter)
    }
    
    public init(animationUrl: URL?, configUrl: URL, placeholderImage: UIImage? = .none, interpreter: ExpressionInterpreter? = .none) {
        super.init(frame: .zero)
        
        let yamlString = try! String(contentsOf: configUrl)
        let yaml = try! Yaml.load(yamlString)
        
        config = yaml
        
        let animationLayout = Layout.fromYaml(v: yaml["animation container"]["layout"]) ?? Layout.zero()
        let labelLayout = Layout.fromYaml(v: yaml["label container"]["layout"]) ?? Layout.zero()
        
        setup(animationLayout: animationLayout, labelLayout: labelLayout, interpreter: interpreter)
        lottieContainer.replaceAnimation(animationUrl: animationUrl, placeholderImage: placeholderImage)
    }
    
    public init (placeholderImage: UIImage) {
        super.init(frame: .zero)
        config = Yaml(stringLiteral: "")
        setup()
        lottieContainer.replaceAnimation(animationUrl: .none, placeholderImage: placeholderImage)
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
        
        debugTouchableAreaView.backgroundColor = UIColor(red: 1.0, green: 0.5, blue: 0.5, alpha: 0.5)
        debugTouchableAreaView.isUserInteractionEnabled = false
    }

    public func loadLottie(url: URL) -> () {
        lottieContainer.replaceAnimation(animationUrl: url, placeholderImage: .none)
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
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if isHidden || !isUserInteractionEnabled {
            return super.point(inside: point, with: event)
        }
        
        let animationViewFrame = lottieContainer.contentViewFrame()
        let labelViewFrame = labelContainer.contentViewFrame()
        
        let actionRect = animationViewFrame.union(labelViewFrame)
        debugTouchableAreaView.frame = actionRect
        
        return actionRect.contains(point)
    }
    
    public func correctionAnchorPoint() -> () {
        guard lottieContainer != .none && labelContainer != .none else { return () }
        _ = point(inside: .zero, with: .none)
        updateAnchorPoint()
    }
    
    public func visibleAreaFrame(to: UIView) -> CGRect {
        return convert(debugTouchableAreaView.frame, to: to)
    }
    
    private func updateAnchorPoint() -> () {
        let visibleAreaFrame = debugTouchableAreaView.frame
        let visibleAreaCenter = CGPoint(x: visibleAreaFrame.midX, y: visibleAreaFrame.midY)
        let newAnchorPoint = CGPoint(x: visibleAreaCenter.x / bounds.width, y: visibleAreaCenter.y / bounds.height)

        guard visibleAreaCenter != .zero else { return () }
        StickerContainer.setAnchorPoint(anchorPoint: newAnchorPoint, forView: self)
        
    }
    
    static func setAnchorPoint(anchorPoint: CGPoint, forView view: UIView) {
        var newPoint = CGPoint(x: view.bounds.size.width * anchorPoint.x, y: view.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPoint(x: view.bounds.size.width * view.layer.anchorPoint.x, y: view.bounds.size.height * view.layer.anchorPoint.y)
        
        newPoint = newPoint.applying(view.transform)
        oldPoint = oldPoint.applying(view.transform)
        
        var position = view.layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        view.layer.position = position
        view.layer.anchorPoint = anchorPoint
    }
    
}
