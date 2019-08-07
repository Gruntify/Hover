//
//  HoverItem.swift
//  Hover
//
//  Created by Pedro Carrasco on 13/07/2019.
//  Copyright © 2019 Pedro Carrasco. All rights reserved.
//

import UIKit

// MARK: - HoverItem
public struct HoverItem {
    
    // MARK: Properties
    let title: String?
    let image: UIImage?
    let imageTintColor: UIColor?
    let onTap: () -> ()
    
    // MARK: Lifecycle
    public init(title: String? = nil, image: UIImage?, imageTintColor: UIColor? = nil, onTap: @escaping () -> ()) {
        self.title = title
        self.image = image
        self.imageTintColor = imageTintColor
        self.onTap = onTap
    }
}
