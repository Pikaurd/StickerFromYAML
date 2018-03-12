//
//  LabelContainerView.swift
//  StickerFromYAML
//
//  Created by hirochin on 09/03/2018.
//

import UIKit
import YogaKit
import Yaml

class LabelContainerView: GridContainerView {
    
    var labels = Array<UILabel>()

    func fillLabels(by config: Yaml) -> () {
        guard let arr = config.array else { return () }
        
        for i in 0..<arr.count {
            let v = UILabel()
            
            v.configureLayout { layout in
                layout.isEnabled = true
//                layout.flexBasis = 20
                layout.height = 20
            }
//            v.text = "#\(i)"
            v.backgroundColor = .red
            labels.append(v)
            
            centerView.addSubview(v)
        }
        
    }

}
