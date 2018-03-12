//
//  ViewController.swift
//  StickerFromYAML
//
//  Created by Chen Hao on 03/09/2018.
//  Copyright (c) 2018 Chen Hao. All rights reserved.
//

import UIKit
import StickerFromYAML

class ViewController: UIViewController {
    
    var stickerView: StickerContainer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = Bundle.main.url(forResource: "snowing", withExtension: "json")!
        let yamlURL = Bundle.main.url(forResource: "snowing", withExtension: "yaml")!
        
        stickerView = StickerContainer(animationUrl: url, configUrl: yamlURL)
        stickerView.frame = CGRect(origin: .zero, size: CGSize(width: 300, height: 300))
        stickerView.center = view.center
        view.addSubview(stickerView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let url = Bundle.main.url(forResource: "snowing", withExtension: "json")!
        stickerView.loadLottie(url: url)
        stickerView.lottieView.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

}

