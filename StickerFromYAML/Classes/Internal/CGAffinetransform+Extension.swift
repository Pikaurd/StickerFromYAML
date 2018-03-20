//
//  CGAffinetransform+Extension.swift
//  StickerFromYAML
//
//  Created by hirochin on 20/03/2018.
//

import CoreGraphics

extension CGAffineTransform {
    var xScale: CGFloat { return sqrt(self.a * self.a + self.c * self.c) }
    var yScale: CGFloat { return sqrt(self.b * self.b + self.d * self.d) }
    var rotation: CGFloat { return CGFloat(atan2f(Float(self.b), Float(self.a))) }
    // .tx and .ty are already available in the transform
}
