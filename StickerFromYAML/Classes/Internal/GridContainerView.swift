//
//  GridContainerView.swift
//  StickerFromYAML
//
//  Created by hirochin on 09/03/2018.
//

import UIKit
import YogaKit
import JavaScriptCore

class GridContainerView: UIView {
    
    let topContainerView = UIView()
    let middleContainerView = UIView()
    let bottomContainerView = UIView()
    
    let leftMarginView = UIView()
    var centerView = UIView()
    let rightMarginView = UIView()
    
    var interpreter: ExpressionInterpreter?
    
    let layout: Layout

    override init(frame: CGRect) {
        self.layout = Layout.zero()
        super.init(frame: frame)
        setup()
        setupYoga()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.layout = Layout.zero()
        super.init(coder: aDecoder)
        setup()
        setupYoga()
    }
    
    init(frame: CGRect, layout: Layout, interpreter: ExpressionInterpreter? = .none) {
        self.layout = layout
        super.init(frame: frame)
        self.interpreter = interpreter
        setup()
        setupYoga()
    }
    
    func setup() -> () {
        addSubview(topContainerView)
        addSubview(middleContainerView)
        addSubview(bottomContainerView)
        
        switch layout.align {
        case .left:
            middleContainerView.addSubview(centerView)
            middleContainerView.addSubview(leftMarginView)
            middleContainerView.addSubview(rightMarginView)
            
        case .right:
            middleContainerView.addSubview(leftMarginView)
            middleContainerView.addSubview(rightMarginView)
            middleContainerView.addSubview(centerView)
            
        default:
            middleContainerView.addSubview(leftMarginView)
            middleContainerView.addSubview(centerView)
            middleContainerView.addSubview(rightMarginView)
        }
        
        configureLayout { layout in
            layout.isEnabled = true
            layout.flexGrow = 100
        }

    }

    func setupYoga() -> () {
        // setup containers
        topContainerView.configureLayout(block: GridContainerView.containerYogaSetup(flex: layout.up))
        middleContainerView.configureLayout(block: GridContainerView.containerYogaSetup(flex: 100))
        bottomContainerView.configureLayout(block: GridContainerView.containerYogaSetup(flex: layout.down))
        
        leftMarginView.configureLayout(block: GridContainerView.containerYogaSetup(flex: layout.left))
        centerView.configureLayout { layout in
            layout.isEnabled = true
            layout.flexGrow = 100
            layout.justifyContent = YGJustify.spaceAround
        }
        rightMarginView.configureLayout(block: GridContainerView.containerYogaSetup(flex: layout.right))
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
    
    func centerViewFrameInView() -> CGRect {
        return middleContainerView.convert(centerView.frame, to: self)
    }
    
    func foo() -> CGRect {
        let allCapacity = 300 as CGFloat
        let totalMargin = layout.left + layout.right
        let usedCapacity = allCapacity - totalMargin
        
        let height = bounds.height * usedCapacity / allCapacity
        let centerViewOrigin = CGPoint(x: 0, y: totalMargin * 0.5 / allCapacity * bounds.height)
        let centerViewSize = CGSize(width: centerView.bounds.width, height: height)
        
        return CGRect(origin: centerViewOrigin, size: centerViewSize)
    }

}
