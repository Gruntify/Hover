//
//  HoverItemView.swift
//  Hover
//
//  Created by Pedro Carrasco on 13/07/2019.
//  Copyright © 2019 Pedro Carrasco. All rights reserved.
//

import UIKit

// MARK: - HoverItemView
class HoverItemView: UIStackView {
    
    // MARK: Constant
    private enum Constant {
        static let interItemSpacing: CGFloat = 8.0
    }
    
    // MARK: Outlets
    private let button: HoverButton
    private let label = ItemLabelView()
    
    // MARK: Properties
    var onTap: (() -> ())?
    var orientation: Orientation.X {
        didSet { adapt(to: orientation) }
    }
    
    // MARK: Private Properties
    private let item: HoverItem
    
    // MARK: Lifecycle
    init(with item: HoverItem, configuration: HoverItemConfiguration) {
        self.item = item
        self.orientation = configuration.initialXOrientation
        self.button = HoverButton(with: configuration.color, image: item.image, imageSizeRatio: configuration.imageSizeRatio, scaleDownTransform: configuration.scaleDownTransform, shadow: configuration.shadow)
        self.button.imageTintColor = item.imageTintColor
        label.label.textColor = configuration.textColor
        label.insets = configuration.labelInsets
        label.roundedView.backgroundColor = configuration.labelBackgroundColor
        label.shadowView.addShadow(configuration.labelBackgroundShadow)
        label.roundedView.roundedSides = configuration.labelBackgroundIsRounded
        
        if let font = configuration.font {
            self.label.label.font = font
        }
        
        self.label.label.text = item.title
        super.init(frame: .zero)
        configure(with: configuration)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configuration
private extension HoverItemView {
    
    func configure(with configuration: HoverItemConfiguration) {
        spacing = Constant.interItemSpacing
        
        addSubviews()
        defineConstraints(with: configuration.size)
        setupSubviews()
    }
    
    func addSubviews() {
        adapt(to: orientation)
    }
    
    func defineConstraints(with size: CGFloat) {
        NSLayoutConstraint.activate(
            [
                button.heightAnchor.constraint(equalToConstant: size),
                button.widthAnchor.constraint(equalTo: button.heightAnchor)
            ]
        )
    }
    
    func setupSubviews() {
        button.addTarget(self, action: #selector(onTapInButton), for: .touchUpInside)
    }
}

// MARK: - Actions
private extension HoverItemView {
    
    @objc
    func onTapInButton() {
        item.onTap()
        onTap?()
    }
}

// MARK: - Condional Constraints
private extension HoverItemView {
    
    func adapt(to orientation: Orientation.X) {
        switch orientation {
        case .leftToRight:
            label.label.textAlignment = .left
            add(arrangedViews: button, label)
        case .rightToLeft:
            label.label.textAlignment = .right
            add(arrangedViews: label, button)
        }
        label.adapt(to: orientation)
    }
}

class ItemLabelView: UIView {
    
    let shadowView = UIView()
    let roundedView = RoundedView()
    let label = UILabel()
    
    var insets: UIEdgeInsets = .zero {
        didSet {
            topConstraint.constant = insets.top
            leadingConstraint.constant = insets.left
            trailingConstraint.constant = -insets.right
            bottomConstraint.constant = -insets.bottom
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    private var topConstraint: NSLayoutConstraint!
    private var leadingConstraint: NSLayoutConstraint!
    private var trailingConstraint: NSLayoutConstraint!
    private var bottomConstraint: NSLayoutConstraint!
    private func setUp() {
        // Note: Pretty sure we don't need the extra "roundedView" and could just stretch the label
        //       and round it, but can't seem to get the constraints right...
        self.add(views: shadowView)
        shadowView.add(views: roundedView)
        roundedView.add(views: label)
        label.translatesAutoresizingMaskIntoConstraints = false
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = label.topAnchor.constraint(equalTo: shadowView.topAnchor)
        leadingConstraint = label.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor)
        trailingConstraint = label.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor)
        bottomConstraint = label.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor)
        NSLayoutConstraint.activate(
            [
                roundedView.widthAnchor.constraint(equalTo: shadowView.widthAnchor),
                roundedView.heightAnchor.constraint(equalTo: shadowView.heightAnchor),
                topConstraint,
                leadingConstraint,
                trailingConstraint,
                bottomConstraint,
            ]
        )
    }
    
    func adapt(to orientation: Orientation.X) {
        switch orientation {
        case .leftToRight:
            label.textAlignment = .left
            shadowView.removeFromSuperview()
            addSubview(shadowView)
            NSLayoutConstraint.activate(
                [
                    shadowView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
                    shadowView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    shadowView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
                    shadowView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
                    shadowView.centerYAnchor.constraint(equalTo: centerYAnchor),
                ]
            )
        case .rightToLeft:
            label.textAlignment = .right
            shadowView.removeFromSuperview()
            addSubview(shadowView)
            NSLayoutConstraint.activate(
                [
                    shadowView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
                    shadowView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
                    shadowView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    shadowView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
                    shadowView.centerYAnchor.constraint(equalTo: centerYAnchor),
                ]
            )
        }
    }
    
    
}

class RoundedView: UIView {
    
    var roundedSides = true {
        didSet {
            updateForRoundedSides()
        }
    }
    
    private func updateForRoundedSides() {
        if roundedSides {
            self.layer.masksToBounds = true
        }
        setNeedsLayout()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    private func setUp() {
        updateForRoundedSides()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if roundedSides {
            self.layer.cornerRadius = bounds.height / 2
        }
    }
    
}
