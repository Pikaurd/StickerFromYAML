//
//  AnimationContainerView.swift
//  StickerFromYAML
//
//  Created by hirochin on 09/03/2018.
//

import UIKit
import Lottie
import SDWebImage

class AnimationContainerView: GridContainerView {
    
    var lottieView = LOTAnimationView()
    private let gifView = FLAnimatedImageView()
    
    override func setup() {
        super.setup()
        
        centerView.addSubview(gifView)
        gifView.frame = bounds
        gifView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        gifView.contentMode = .scaleAspectFit
    }
    
    func replaceAnimation(animationUrl: URL?, placeholderImage: UIImage?) -> () {
        guard let animationUrl = animationUrl else {
            gifView.image = placeholderImage
            return ()
        }
        
        if (animationUrl.path.hasSuffix("json")) {
            loadLottie(url: animationUrl)
        }
        else {
            lottieView.removeFromSuperview()
            loadGif(url: animationUrl, placeholderImage: placeholderImage)
        }
    }
    
    private func loadLottie(url: URL) -> () {
        lottieView.removeFromSuperview()
        lottieView = LOTAnimationView(contentsOf: url)
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopAnimation = true
        lottieView.frame = centerView.bounds
        lottieView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        centerView.addSubview(lottieView)
    }
    
    private func loadGif(url: URL, placeholderImage: UIImage?) -> () {
        gifView.sd_setImage(with: url, placeholderImage: placeholderImage, options: .retryFailed, completed: .none)
    }

}
