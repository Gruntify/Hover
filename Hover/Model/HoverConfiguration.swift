//
//  HoverConfiguration.swift
//  Hover
//
//  Created by Pedro Carrasco on 14/07/2019.
//  Copyright © 2019 Pedro Carrasco. All rights reserved.
//

import UIKit

// MARK: - HoverConfiguration
public struct HoverConfiguration {
    
    // MARK: Constant
    private enum Constant {
        static let itemSizeRatio: CGFloat = 0.75
        static let defaultSize: CGFloat = 60.0
    }
    
    // MARK: Properties
    /// Color / Gradient of the floating button
    public var color: HoverColor
    /// Color of the item buttons
    public var itemColor: HoverColor
    /// Image displayed in the floating button
    public var image: UIImage?
    /// Size of the floating button
    public var size: CGFloat
    /// Dictates the size of the image shown in any button (imageSize = size * imageSizeRatio)
    public var imageSizeRatio: CGFloat
    /// Transform of button when highlighted.
    public var scaleDownTransform: CGAffineTransform
    /// Shadows applied to the button.
    public var shadow: HoverShadow
    /// Transform of image when button is opened
    public var imageOpenedTransform: CGAffineTransform
    /// Spacing between the floating button to the edges
    public var spacing: CGFloat
    /// Whether or not spacing is used for button's bottom constraints when there's a non-zero height safe area (eg. iPhone X)
    /// - Note: [StackOverflow Reference](https://stackoverflow.com/a/53634824/)
    public var constrainBottomToSafeAreaIfNonZeroHeight: Bool
    /// Font used in items' labels
    public var font: UIFont?
    /// Text color used for item labels
    public var textColor: UIColor
    /// Color of the overlay
    public var dimColor: UIColor
    /// Initial position of the floating button
    public var initialPosition: HoverPosition
    /// Allowed positions in which the floating button can be placed
    public var allowedPositions: Set<HoverPosition>
    /// Insets around the item labels.
    public var labelInsets: UIEdgeInsets
    /// Background color of the item labels.
    public var labelBackgroundColor: UIColor
    /// Shadows applied to the item labels.
    public var labelBackgroundShadow: HoverShadow
    /// Whether the label background is rounded.
    public var labelBackgroundIsRounded: Bool
    
    var itemConfiguration: HoverItemConfiguration {
        return HoverItemConfiguration(
            size: size * Constant.itemSizeRatio,
            color: itemColor,
            imageSizeRatio: imageSizeRatio,
            scaleDownTransform: scaleDownTransform,
            shadow: shadow,
            margin: size * ((1 - Constant.itemSizeRatio) / 2),
            font: font,
            textColor: textColor,
            initialXOrientation: initialPosition.xOrientation,
            labelInsets: labelInsets,
            labelBackgroundColor: labelBackgroundColor,
            labelBackgroundShadow: labelBackgroundShadow,
            labelBackgroundIsRounded: labelBackgroundIsRounded
        )
    }
    
    // MARK: Init
    public init(
        image: UIImage? = nil,
        color: HoverColor = .color(.blue),
        itemColor: HoverColor = .color(.white),
        size: CGFloat = 60.0,
        imageSizeRatio: CGFloat = 0.4,
        scaleDownTransform: CGAffineTransform = CGAffineTransform(scaleX: 0.9, y: 0.9),
        shadow: HoverShadow = HoverShadow(),
        imageOpenedTransform: CGAffineTransform = .identity,
        spacing: CGFloat = 12.0,
        constrainBottomToSafeAreaIfNonZeroHeight: Bool = false,
        font: UIFont? = nil,
        textColor: UIColor = .white,
        dimColor: UIColor = UIColor.black.withAlphaComponent(0.75),
        initialPosition: HoverPosition = .bottomRight,
        allowedPositions: Set<HoverPosition> = .all,
        labelInsets: UIEdgeInsets = .zero,
        labelBackgroundColor: UIColor = .clear,
        labelBackgroundShadow: HoverShadow = HoverShadow(opacity: 0),
        labelBackgroundIsRounded: Bool = true
        ) {
        self.color = color
        self.itemColor = itemColor
        self.image = image
        self.size = size
        self.imageSizeRatio = imageSizeRatio
        self.scaleDownTransform = scaleDownTransform
        self.shadow = shadow
        self.imageOpenedTransform = imageOpenedTransform
        self.spacing = spacing
        self.constrainBottomToSafeAreaIfNonZeroHeight = constrainBottomToSafeAreaIfNonZeroHeight
        self.font = font
        self.textColor = textColor
        self.dimColor = dimColor
        self.initialPosition = initialPosition
        self.allowedPositions = allowedPositions
        self.labelInsets = labelInsets
        self.labelBackgroundColor = labelBackgroundColor
        self.labelBackgroundShadow = labelBackgroundShadow
        self.labelBackgroundIsRounded = labelBackgroundIsRounded
    }
}

// MARK: - HoverItemConfiguration
struct HoverItemConfiguration {
    
    let size: CGFloat
    let color: HoverColor
    let imageSizeRatio: CGFloat
    let scaleDownTransform: CGAffineTransform
    let shadow: HoverShadow
    let margin: CGFloat
    let font: UIFont?
    let textColor: UIColor
    let initialXOrientation: Orientation.X
    let labelInsets: UIEdgeInsets
    let labelBackgroundColor: UIColor
    let labelBackgroundShadow: HoverShadow
    let labelBackgroundIsRounded: Bool
}

