//
//  ShrinkedView.swift
//  StickerFromYAML
//
//  Created by hirochin on 02/04/2018.
//

import UIKit

@objc
public class ShrunkStickerView: UIView {
    @objc public let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() -> () {
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
    }
}
