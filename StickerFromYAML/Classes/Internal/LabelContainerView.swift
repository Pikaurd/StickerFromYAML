//
//  LabelContainerView.swift
//  StickerFromYAML
//
//  Created by hirochin on 09/03/2018.
//

import UIKit
import SnapKit
import Yaml

class LabelContainerView: GridContainerView {
    
    private let labelHeight = 20
    
    var labels = Array<UILabel>()

    func fillLabels(by config: Yaml) -> () {
        guard let arr = config.array else { return () }
        
        for i in 0..<arr.count {
            let v = UILabel()
            centerView.addSubview(v)
            
            v.textColor = .white
            v.font = UIFont.systemFont(ofSize: 18)
            v.text = config[i].string ?? ""
            labels.append(v)
        }
        
        for i in 0..<arr.count {
            let v = labels[i]
            
            v.snp.makeConstraints { make in
                make.left.equalTo(self.centerView)
                make.right.equalTo(self.centerView)
                if i == 0 {
                    make.top.equalTo(self.centerView)
                }
                else {
                    make.top.equalTo(self.labels[i - 1].snp.bottom)
                    make.height.equalTo(self.labels[i - 1])
                }
                
                if i == arr.count - 1 {
                    make.bottom.equalTo(self.centerView.snp.bottom)
                }
                else {
                    make.bottom.equalTo(self.labels[i + 1].snp.top)
                }
            }
        }
        
    }

}
