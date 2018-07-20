//
//  UIActivityIndicatorView.swift
//  HeadHunterChat
//
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {

    func scale(factor: CGFloat) {
        guard factor > 0.0 else {
            return
        }

        transform = CGAffineTransform(scaleX: factor, y: factor)
    }

}
