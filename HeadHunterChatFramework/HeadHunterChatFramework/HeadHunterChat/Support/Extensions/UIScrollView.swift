//
//  UIScrollView.swift
//  HeadHunterChat
//
//  Created by 12345 on 27.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

extension UIScrollView {

    private enum Constants {
        static let distanceForShowArrow: CGFloat = 150
    }

    func shouldLoadData(loadDistance: CGFloat) -> Bool {
        let y = contentOffset.y + bounds.size.height - contentInset.bottom
        let height = contentSize.height
        let position = y + loadDistance
        return position > height
    }

    func shouldShowArrowToBottom() -> Bool {
        return contentOffset.y > Constants.distanceForShowArrow
    }

}
