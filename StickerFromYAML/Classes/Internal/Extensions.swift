//
//  Extensions.swift
//  StickerFromYAML
//
//  Created by hirochin on 23/03/2018.
//

import CoreGraphics


func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
}

func * (lhs: CGRect, rhs: CGFloat) -> CGRect {
    return CGRect(
        x: lhs.origin.x * rhs,
        y: lhs.origin.y * rhs,
        width: lhs.size.width * rhs,
        height: lhs.size.height * rhs
    )
}
