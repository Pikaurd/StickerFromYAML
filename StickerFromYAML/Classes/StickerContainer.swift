//
//  StickerContainer.swift
//  StickerFromYAML
//
//  Created by hirochin on 09/03/2018.
//

import UIKit
import Lottie

public class StickerContainer: UIView {
    
    let lottieContainer = AnimationContainerView()
    let labelContainer = LabelContainerView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() -> () {
        lottieContainer.isUserInteractionEnabled = false
        labelContainer.isUserInteractionEnabled = false
        
        lottieContainer.frame = bounds
        labelContainer.frame = bounds
        
        lottieContainer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        labelContainer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(lottieContainer)
        addSubview(labelContainer)
    }

    public func loadLottie(url: URL) -> () {
//        lottieContainer.cen
    }
}
