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
        
        view.backgroundColor = .black
        
        let name = "指南针扁平风格"
//        let name = "中国"
        let url = Bundle.main.url(forResource: name, withExtension: "webp")!
        let yamlURL = Bundle.main.url(forResource: name, withExtension: "yaml")!
        
        let size = 200
        stickerView = StickerContainer(animationUrl: url, configUrl: yamlURL, placeholderImage: .none, interpreter: InterpreterProvider.default)
//        stickerView.debugMode = true
//        stickerView = StickerContainer(placeholderImage: #imageLiteral(resourceName: "placeholder"))
        stickerView.frame = CGRect(origin: .zero, size: CGSize(width: size, height: size))
        stickerView.transform = CGAffineTransform(rotationAngle: .pi * 0.25).scaledBy(x: 1.1, y: 1.1)
//        stickerView.transform = CGAffineTransform(rotationAngle: 0).scaledBy(x: 1.2, y: 1.2)
//        stickerView.center = CGPoint(x: 100, y: 100)
        stickerView.center = CGPoint(x: view.center.x, y: view.center.y)
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
            
            let l = CALayer()
            l.anchorPoint = self.stickerView.layer.anchorPoint
            l.bounds = self.stickerView.bounds
            l.position = self.stickerView.layer.position
            l.backgroundColor = UIColor(white: 1.0, alpha: 0.1).cgColor
            l.setAffineTransform(self.stickerView.transform)
            
            let il = CALayer()
            il.bounds = self.stickerView.animationContainerView.bounds
            il.position = self.stickerView.animationContainerView.layer.position
            il.backgroundColor = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.1).cgColor
            
            l.addSublayer(il)
            
            let ll = self.stickerView.labelLayer()
            ll.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0, alpha: 0.2).cgColor
            l.addSublayer(ll)
            
            self.view.layer.addSublayer(l)
            
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

