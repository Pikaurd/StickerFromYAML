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

func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
}

func * (lhs: CGRect, rhs: CGFloat) -> CGRect {
    return CGRect(
        x: lhs.origin.x * rhs,
        y: lhs.origin.y * rhs,
        width: lhs.size.width * rhs,
        height: lhs.size.height * rhs
    )
}

extension UIFont {
    func sizeOfString (string: String, constrainedToWidth width: Double) -> CGSize {
        return NSString(string: string).boundingRect(
            with: CGSize(width: width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: self],
            context: nil).size
    }
}
