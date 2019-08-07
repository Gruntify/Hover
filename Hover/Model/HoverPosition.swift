//
//  HoverPosition.swift
//  Hover
//
//  Created by Pedro Carrasco on 12/07/2019.
//  Copyright © 2019 Pedro Carrasco. All rights reserved.
//

import UIKit

// MARK: - HoverPosition
public enum HoverPosition {
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}

// MARK: - Properties
extension HoverPosition {
    
    var xOrientation: Orientation.X {
        switch self {
        case .topLeft, .bottomLeft:
            return .leftToRight
        case .topRight, .bottomRight:
            return .rightToLeft
        }
    }
    
    var yOrientation: Orientation.Y {
        switch self {
        case .bottomLeft, .bottomRight:
            return .bottomToTop
        case .topLeft, .topRight:
            return .topToBottom
        }
    }
}

// MARK: - Configuration
extension HoverPosition {

    func configurePosition(of guide: UILayoutGuide, inside view: UIView, with spacing: CGFloat) {
        let positionConstraints: [NSLayoutConstraint]
        switch self {
        case .topLeft:
            positionConstraints = [
                guide.topAnchor.constraint(equalTo: view.safeAreaTopAnchor, constant: spacing),
                guide.leadingAnchor.constraint(equalTo: view.safeAreaLeadingAnchor, constant: spacing)
            ]
        case .topRight:
            positionConstraints = [
                guide.topAnchor.constraint(equalTo: view.safeAreaTopAnchor, constant: spacing),
                guide.trailingAnchor.constraint(equalTo: view.safeAreaTrailingAnchor, constant: -spacing)
            ]
        case .bottomLeft:
            positionConstraints = [
                guide.bottomAnchor.constraint(equalTo: view.safeAreaBottomAnchor, constant: -spacing),
                guide.leadingAnchor.constraint(equalTo: view.safeAreaLeadingAnchor, constant: spacing)
            ]
        case .bottomRight:
            positionConstraints = [
                guide.bottomAnchor.constraint(equalTo: view.safeAreaBottomAnchor, constant: -spacing),
                guide.trailingAnchor.constraint(equalTo: view.safeAreaTrailingAnchor, constant: -spacing)
            ]
        }
        NSLayoutConstraint.activate(positionConstraints)
    }
}

// MARK: - Sugar
public extension Set where Element == HoverPosition {

    static let all: Set<HoverPosition> = [.topLeft, .topRight, .bottomLeft, .bottomRight]
}

// MARK: - CaseIterable
extension HoverPosition: CaseIterable {}

// MARK: - Equatable
extension HoverPosition: Equatable {}

// MARK: - Safe area
extension UIView {
    
    var safeAreaTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        } else {
            return topAnchor
        }
    }
    var safeAreaBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        } else {
            return bottomAnchor
        }
    }
    var safeAreaLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leadingAnchor
        } else {
            return leadingAnchor
        }
    }
    var safeAreaTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.trailingAnchor
        } else {
            return trailingAnchor
        }
    }
}
