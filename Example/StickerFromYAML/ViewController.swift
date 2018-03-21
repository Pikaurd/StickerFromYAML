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
        
        let url = Bundle.main.url(forResource: "雨天青蛙", withExtension: "webp")!
        let yamlURL = Bundle.main.url(forResource: "snowing", withExtension: "yaml")!
                
        stickerView = StickerContainer(animationUrl: url, configUrl: yamlURL, interpreter: InterpreterProvider.default)
        stickerView.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
//        stickerView.center = CGPoint(x: view.center.x, y: stickerView.frame.size.height * 2 + 10)
        stickerView.center = view.center
        stickerView.backgroundColor = .gray
        view.addSubview(stickerView)
        
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
            
            UIView.animate(withDuration: 1.0, animations: {
                self.stickerView.transform = CGAffineTransform(scaleX: 3, y: 3)
            }, completion: { _ in
                self.stickerView.setNeedsLayout()
                self.stickerView.layoutIfNeeded()
            })
//            let v = self.stickerView.getLabelView()
//            v.frame.origin.y += 300
//            v.backgroundColor = .black
//            self.view.addSubview(v)
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

