//
//  LabelContainerView.swift
//  StickerFromYAML
//
//  Created by hirochin on 09/03/2018.
//

import UIKit
import SnapKit
import Yaml
import JavaScriptCore

class LabelContainerView: GridContainerView {
    
    private var baseFontSize = 9 as CGFloat
    
    var labels = Array<UILabel>()

    func fillLabels(by config: Yaml) -> () {
        if let fontSize = config["font size"].int {
            baseFontSize = CGFloat(fontSize)
        }
        guard let arr = config["labels"].array else { return () }
        
        for i in 0..<arr.count {
            let v = UILabel()
            centerView.addSubview(v)
            
            v.textColor = .white
            v.font = UIFont(name: "PingFangSC-Semibold", size: baseFontSize * 10)
            v.text = fillLabel(s: arr[i].string ?? "")
            labels.append(v)
        }
        
    }
    
    func animationLayer() -> CALayer {
        let resultLayer = CALayer()
        resultLayer.frame = frame
        
        for l in labels {
            let origin = centerView.convert(l.frame.origin, to: self)
            
            let textLayer = CATextLayer()
            textLayer.fontSize = l.font.pointSize
            textLayer.font = l.font
            textLayer.foregroundColor = l.textColor.cgColor
            textLayer.backgroundColor = UIColor.clear.cgColor
            textLayer.string = l.text
            textLayer.frame = CGRect(origin: origin, size: l.frame.size)
            
            resultLayer.addSublayer(textLayer)
        }
        
        
        return resultLayer
    }
    
    func labelView(container: UIView) -> UIView {
        let v = UIView()
        v.frame = container.frame
        for l in labels {
            let scale = container.transform.xScale
            let newLabel = UILabel()
            newLabel.font = l.font.withSize(baseFontSize * scale)
            newLabel.text = l.text
            newLabel.textColor = l.textColor
            let origin = centerView.convert(l.frame.origin, to: self)
            let newLabelFrame = CGRect(origin: origin, size: l.frame.size)
            newLabel.frame = newLabelFrame.applying(CGAffineTransform(scaleX: container.transform.xScale, y: container.transform.yScale))
            v.addSubview(newLabel)
        }
        return v
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let scale = bounds.width / 3000  // base width is 300, and base scale is 0.1 therefore using width divide 3000
        let labelSize = CGSize(width: centerView.bounds.width, height: centerView.bounds.height / CGFloat(labels.count))
        for i in 0 ..< labels.count {
            let v = labels[i]
            v.frame = CGRect(origin: .zero, size: labelSize)
            v.transform = CGAffineTransform(scaleX: scale, y: scale)
            v.center = CGPoint(x: centerView.bounds.width * 0.5, y: labelSize.height * (0.5 + CGFloat(i)))
        }

    }
    
    private func fillLabel(s: String) -> String {
        if s.hasPrefix("@") {
            let expression = s.replacingOccurrences(of: "@", with: "")
            return expressionEvalute(expression: expression)
        }
        return s
    }

    private func expressionEvalute(expression: String) -> String {
        guard let jsEngine = interpreter?.interpreter() else { return "Exp err" }

        jsEngine.evaluateScript(expression)
        let result = jsEngine.evaluateScript("text()")
        
        return result?.toString() ?? "- none -"
    }

}
