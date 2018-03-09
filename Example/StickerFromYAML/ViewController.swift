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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let stickerView = StickerContainer()
        stickerView.frame = CGRect(origin: .zero, size: CGSize(width: 300, height: 300))
        stickerView.center = view.center
        view.addSubview(stickerView)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

