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
    let animatedImageView = FLAnimatedImageView()
    private let loadingActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
    override func setup() {
        super.setup()
        
        centerView.addSubview(animatedImageView)
        animatedImageView.contentMode = .scaleAspectFit
        
        loadingActivityIndicator.frame = animatedImageView.bounds
        loadingActivityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        animatedImageView.addSubview(loadingActivityIndicator)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let scale = layout.scale
        let anchor = layout.anchorPoint
        let origin = CGPoint(
            x: centerView.bounds.width * (1 - scale) * anchor.x,
            y: centerView.bounds.height * ((1 - scale) * anchor.y)
        )
        let size = CGSize(width: centerView.bounds.width * scale, height: centerView.bounds.height * scale)
        animatedImageView.frame = CGRect(origin: origin, size: size)
    }
    
    func replaceAnimation(animationUrl: URL?, placeholderImage: UIImage?) -> () {
        guard let animationUrl = animationUrl else {
            animatedImageView.image = placeholderImage
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
    
    override func contentViewFrame() -> CGRect {
        let animFrame = centerView.convert(animatedImageView.frame, to: self)
        let shrinkToRectangle: CGRect
        if animFrame.width > animFrame.height {
            let offset = (animFrame.width - animFrame.height) * 0.5
            shrinkToRectangle = CGRect(x: animFrame.minX + offset, y: animFrame.minY, width: animFrame.width - offset * 2, height: animFrame.height)
        }
        else if animFrame.width < animFrame.height {
            let offset = (animFrame.height - animFrame.width) * 0.5
            shrinkToRectangle = CGRect(x: animFrame.minX, y: animFrame.minY + offset, width: animFrame.width, height: animFrame.height - offset * 2)
        }
        else {
            shrinkToRectangle = animFrame
        }
        
        return shrinkToRectangle
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
        loadingActivityIndicator.startAnimating()
        animatedImageView.sd_setImage(with: url, placeholderImage: placeholderImage, options: .retryFailed) { (_, _, _, _) in
            self.loadingActivityIndicator.stopAnimating()
        }
    }

}
