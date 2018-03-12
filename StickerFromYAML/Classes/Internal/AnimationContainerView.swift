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
        
        lottieView.configureLayout { layout in
            layout.isEnabled = true
            layout.flexGrow = 1
        }
        
        centerView.addSubview(lottieView)
        
        yoga.applyLayout(preservingOrigin: true)
        
        lottieView.backgroundColor = .green
    }

}
