//
//  UIView+Decorators.swift
//  Hover
//
//  Created by Pedro Carrasco on 13/07/2019.
//  Copyright © 2019 Pedro Carrasco. All rights reserved.
//

import UIKit

// MARK: - Gradient
extension UIView {
    
    // MARK: Constant
    private enum GradientConstant {
        static let startPoint = CGPoint(x: 0.5, y: 1.0)
        static let endPoint = CGPoint(x: 0.5, y: 0.0)
        static let locations: [NSNumber] = [0, 1]
    }
    
    // MARK: Functions
    func makeGradientLayer(_ gradientLayer: CAGradientLayer = .init()) -> CAGradientLayer {
        gradientLayer.startPoint = GradientConstant.startPoint
        gradientLayer.endPoint = GradientConstant.endPoint
        gradientLayer.locations = GradientConstant.locations
        layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
}

// MARK: - Shadow

public struct HoverShadow {
    
    // MARK: Constant
    public enum ShadowConstant {
        public static let heightOffset = 0
        public static let opacity: Float = 0.55
        public static let radius: CGFloat = 10
    }
    
    public var color: CGColor
    public var offset: CGSize
    public var opacity: Float
    public var radius: CGFloat
    
    public init(
        color: CGColor = UIColor.black.cgColor,
        offset: CGSize = CGSize(width: 0, height: 5),
        opacity: Float = ShadowConstant.opacity,
        radius: CGFloat = ShadowConstant.radius
        ) {
        self.color = color
        self.offset = offset
        self.opacity = opacity
        self.radius = radius
    }
    
}

extension UIView {
    
    // MARK: Functions
    func addShadow(
        color: CGColor,
        offset: CGSize,
        opacity: Float,
        radius: CGFloat
        ) {
        layer.shadowColor = color
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }
    
    func addShadow(_ shadow: HoverShadow) {
        self.addShadow(
            color: shadow.color,
            offset: shadow.offset,
            opacity: shadow.opacity,
            radius: shadow.radius
        )
    }
}
