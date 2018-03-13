//
//  AnimationContainerView.swift
//  StickerFromYAML
//
//  Created by hirochin on 09/03/2018.
//

import UIKit
import Lottie

class AnimationContainerView: GridContainerView {
    
    var lottieView = LOTAnimationView()
    
    func replaceAnimation(animationUrl: URL) -> () {
        lottieView.removeFromSuperview()
        lottieView = LOTAnimationView(contentsOf: animationUrl)
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopAnimation = true
        lottieView.frame = centerView.bounds
        lottieView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        centerView.addSubview(lottieView)
    }

}
