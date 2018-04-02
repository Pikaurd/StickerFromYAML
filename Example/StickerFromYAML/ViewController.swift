//
//  ViewController.swift
//  StickerFromYAML
//
//  Created by Chen Hao on 03/09/2018.
//  Copyright (c) 2018 Chen Hao. All rights reserved.
//

import UIKit
import StickerFromYAML
import Yaml

class ViewController: UIViewController {
    
    var stickerView: StickerContainer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let name = "指南针扁平风格"
//        let name = "中国"
        let url = Bundle.main.url(forResource: name, withExtension: "webp")!
        let yamlURL = Bundle.main.url(forResource: name, withExtension: "yaml")!
        
        let size = 100
        stickerView = StickerContainer(animationUrl: url, configUrl: yamlURL, placeholderImage: .none, interpreter: InterpreterProvider.default)
//        stickerView.debugMode = true
//        stickerView = StickerContainer(placeholderImage: #imageLiteral(resourceName: "placeholder"))
        stickerView.frame = CGRect(origin: .zero, size: CGSize(width: size, height: size))
        stickerView.transform = CGAffineTransform(rotationAngle: .pi * 0.25).scaledBy(x: 1.1, y: 1.1)
        stickerView.center = CGPoint(x: 300, y: 100)
        stickerView.backgroundColor = .gray
        view.addSubview(stickerView)
        stickerView.correctionAnchorPoint()
        print("stickerView.frame.size: \(stickerView.bounds.size)")
        
        
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureHandle(gesture:)))
        stickerView.addGestureRecognizer(pinchGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        stickerView.lottieView?.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        DispatchQueue.main.async {
            
//            let v = self.stickerView.getLabelView()
//            v.backgroundColor = .black
//            print("frame: \(v.frame.size), bounds.size: \(v.bounds.size)")
//            self.view.addSubview(v)
            
            let v = UIView()
            
            let oBounds = self.stickerView.animationContainerView.bounds
            let animCenter = self.stickerView.animationContainerView.center
            let cCenter = self.stickerView.animationContainerView.superview!.convert(animCenter, to: self.view)
            
            v.transform = self.stickerView.transform
            v.center = cCenter
            v.bounds = self.stickerView.animationContainerView.bounds
            
//            let frame = CGRect(origin: CGPoint(x: cCenter.x - oBounds.width, y: cCenter.y - oBounds.height), size: self.stickerView.animationContainerView.bounds.size)
//            v.frame = frame
            
            v.backgroundColor = UIColor(red: 1.0, green: 0.5, blue: 0.5, alpha: 0.5)
            self.view.addSubview(v)
        }
    }
    
    @objc private func pinchGestureHandle(gesture: UIPinchGestureRecognizer) -> () {
        guard let v = gesture.view else { return () }
        
        let scale = gesture.scale
        v.transform = CGAffineTransform(scaleX: scale, y: scale)
        
//        if gesture.state == .ended {
//            stickerView.setNeedsLayout()
//            stickerView.layoutIfNeeded()
//        }
    }

}

