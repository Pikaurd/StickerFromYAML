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
    var centerView = UIView()
    let rightMarginView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupYoga(layout: Layout(left: 100, up: 100, right: 100, down: 100))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setupYoga(layout: Layout(left: 100, up: 100, right: 100, down: 100))
    }
    
    init(frame: CGRect, layout: Layout) {
        super.init(frame: frame)
        setup()
        setupYoga(layout: layout)
    }
    
    private func setup() -> () {
        addSubview(topContainerView)
        addSubview(middleContainerView)
        addSubview(bottomContainerView)
        
        middleContainerView.addSubview(leftMarginView)
        middleContainerView.addSubview(centerView)
        middleContainerView.addSubview(rightMarginView)
        
        configureLayout { layout in
            layout.isEnabled = true
            layout.flexGrow = 100
        }

    }

    func setupYoga(layout: Layout) -> () {
        // setup containers
        topContainerView.configureLayout(block: GridContainerView.containerYogaSetup(flex: layout.up))
        middleContainerView.configureLayout(block: GridContainerView.containerYogaSetup(flex: 100))
        bottomContainerView.configureLayout(block: GridContainerView.containerYogaSetup(flex: layout.down))
        
        leftMarginView.configureLayout(block: GridContainerView.containerYogaSetup(flex: layout.left))
        centerView.configureLayout { layout in
            layout.isEnabled = true
            layout.flexGrow = 100
            layout.justifyContent = YGJustify.spaceAround
            layout.flexDirection = YGFlexDirection.column
        }
        rightMarginView.configureLayout(block: GridContainerView.containerYogaSetup(flex: layout.right))
        
        topContainerView.backgroundColor = .purple
        middleContainerView.backgroundColor = .lightGray
        bottomContainerView.backgroundColor = .orange
        
        leftMarginView.backgroundColor = .yellow
        rightMarginView.backgroundColor = .blue
    }
    
    static func containerYogaSetup(flex: CGFloat) -> YGLayoutConfigurationBlock {
        return { layout in
            layout.isEnabled = true
            layout.flexGrow = flex
            layout.flexDirection = YGFlexDirection.row
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        yoga.applyLayout(preservingOrigin: false)
    }

}
