//
//  StyleHelpers.swift
//  HeadHunterChat
//
//  Created by 12345 on 04.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

// MARK: Structs
struct TextStyle {

    let font: UIFont
    let color: UIColor
    let numberOfLines: Int
    let paragraphStyle: NSMutableParagraphStyle
    let dateFormat: String
}

// MARK: Helper protocols
protocol TextStyling {
    func setStyle(with text: String, style: TextStyle)
    func setStyle(with date: Date, style: TextStyle)
}

// MARK: - UILabel
extension UILabel: TextStyling {

    func setStyle(with text: String, style: TextStyle) {
        font = style.font
        textColor = style.color
        numberOfLines = style.numberOfLines
        attributedText = NSAttributedString(string: text, attributes: [.paragraphStyle: style.paragraphStyle])
    }

    func setStyle(with date: Date, style: TextStyle) {
        font = style.font
        textColor = style.color
        numberOfLines = style.numberOfLines
        attributedText = NSAttributedString(string: date.getDateInFormat(dateFormat: style.dateFormat),
                                            attributes: [.paragraphStyle: style.paragraphStyle])
    }

}
