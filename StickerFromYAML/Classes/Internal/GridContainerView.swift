//
//  GridContainerView.swift
//  StickerFromYAML
//
//  Created by hirochin on 09/03/2018.
//

import UIKit
import YogaKit

class GridContainerView: UIView {
    
    let topContainerView = UIView()
    let middleContainerView = UIView()
    let bottomContainerView = UIView()
    
    let leftMarginView = UIView()
    var centerView: UIView!
    let rightMarginView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() -> () {
        centerView = generateCenterView()
        
        addSubview(topContainerView)
        addSubview(middleContainerView)
        addSubview(bottomContainerView)
        
        middleContainerView.addSubview(leftMarginView)
        middleContainerView.addSubview(centerView)
        middleContainerView.addSubview(rightMarginView)
        
        configureLayout { layout in
            layout.isEnabled = true
        }
        
        setupYoga()
    }

    func setupYoga() -> () {
        // setup containers
        topContainerView.configureLayout(block: containerYogaSetup())
        middleContainerView.configureLayout(block: containerYogaSetup())
        bottomContainerView.configureLayout(block: containerYogaSetup())
        
        leftMarginView.configureLayout(block: containerYogaSetup())
        centerView.configureLayout(block: containerYogaSetup())
        rightMarginView.configureLayout(block: containerYogaSetup())
    }
    
    private func containerYogaSetup() -> YGLayoutConfigurationBlock {
        return { layout in
            layout.isEnabled = true
            layout.flexGrow = 100
            layout.flexDirection = YGFlexDirection.row
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        yoga.applyLayout(preservingOrigin: false)
    }
    
    func generateCenterView() -> UIView {
        return UIView()
    }
    
}
