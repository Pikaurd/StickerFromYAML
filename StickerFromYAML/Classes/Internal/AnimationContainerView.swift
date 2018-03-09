//
//  AnimationContainerView.swift
//  StickerFromYAML
//
//  Created by hirochin on 09/03/2018.
//

import UIKit
import Lottie

class AnimationContainerView: GridContainerView {

    override func generateCenterView() -> UIView {
        let lotView = LOTAnimationView()
        lotView.contentMode = .scaleAspectFit
        return lotView
    }

}
