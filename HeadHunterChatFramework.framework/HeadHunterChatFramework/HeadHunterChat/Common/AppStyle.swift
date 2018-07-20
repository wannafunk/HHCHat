//
//  AppStyle.swift
//  HeadHunterChat
//
//  Created by 12345 on 20.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

enum AppStyle {

    // MARK: Color
    enum Color {
        static let mainBlue = UIColor(red: 0, green: 0.65, blue: 0.87, alpha: 1)
        static let mainAquamarine = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1)
        static let mainLightGray = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        static let mainGray = UIColor(red: 0.47, green: 0.47, blue: 0.47, alpha: 1)
        static let mainBlack = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        static let mainTransparentGray = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 0.95)
        static let mainDarkGray = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)

        static let black = UIColor.black
        static let gray = UIColor.gray
        static let white = UIColor.white
        static let lightGray = UIColor.lightGray
        static let darkGray = UIColor.darkGray
    }

    // MARK: - Alpha
    enum Alpha {
        static let none = CGFloat(0.0)
        static let veryLow = CGFloat(0.05)
        static let low = CGFloat(0.30)
        static let almostMedium = CGFloat(0.40)
        static let medium = CGFloat(0.50)
        static let moreMedium = CGFloat(0.60)
        static let high = CGFloat(0.87)
        static let full = CGFloat(1.0)
    }

    // MARK: Font
    enum Font {
        static func withSize(_ size: CGFloat, weight: UIFont.Weight) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: weight)
        }
    }

    // MARK: ParagraphStyle
    enum ParagraphStyle {
        static func withProperties(textAlignment: NSTextAlignment, lineSpacing: CGFloat) -> NSMutableParagraphStyle {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = textAlignment
            paragraphStyle.lineSpacing = lineSpacing

            return paragraphStyle
        }
    }

}

// MARK: TextStyle
extension TextStyle {

    // MARK: - SentMessageStyle
    enum SentMessageStyle {
        // MARK: - UILabel
        enum Label {
            static let textStyle = TextStyle(
                font: AppStyle.Font.withSize(16.0, weight: .regular),
                color: AppStyle.Color.white,
                numberOfLines: 0,
                paragraphStyle: AppStyle.ParagraphStyle.withProperties(textAlignment: .natural, lineSpacing: 2),
                dateFormat: "HH:mm"
            )

            static let dateStyle = TextStyle(
                font: AppStyle.Font.withSize(12, weight: .regular),
                color: AppStyle.Color.mainGray,
                numberOfLines: 1,
                paragraphStyle: AppStyle.ParagraphStyle.withProperties(textAlignment: .natural, lineSpacing: 2),
                dateFormat: "HH:mm"
            )

            static let textNoFileStyle = TextStyle(
                font: AppStyle.Font.withSize(16, weight: .regular),
                color: AppStyle.Color.mainBlue,
                numberOfLines: 1,
                paragraphStyle: AppStyle.ParagraphStyle.withProperties(textAlignment: .natural, lineSpacing: 2),
                dateFormat: "HH:mm"
            )

            static let dateNoFileStyle = TextStyle(
                font: AppStyle.Font.withSize(12, weight: .regular),
                color: AppStyle.Color.mainBlue,
                numberOfLines: 1,
                paragraphStyle: AppStyle.ParagraphStyle.withProperties(textAlignment: .natural, lineSpacing: 2),
                dateFormat: "HH:mm"
            )
        }
    }

    // MARK: - Received message
    enum ReceivedMessageStyle {
        // MARK: - UILabel
        enum Label {
            static let textStyle = TextStyle(
                font: AppStyle.Font.withSize(16.0, weight: .regular),
                color: AppStyle.Color.mainBlack,
                numberOfLines: 0,
                paragraphStyle: AppStyle.ParagraphStyle.withProperties(textAlignment: .natural, lineSpacing: 2),
                dateFormat: "HH:mm"
            )

            static let dateStyle = TextStyle(
                font: AppStyle.Font.withSize(12, weight: .regular),
                color: AppStyle.Color.mainGray,
                numberOfLines: 1,
                paragraphStyle: AppStyle.ParagraphStyle.withProperties(textAlignment: .natural, lineSpacing: 2),
                dateFormat: "HH:mm"
            )

            static let textNoFileStyle = TextStyle(
                font: AppStyle.Font.withSize(16, weight: .regular),
                color: AppStyle.Color.mainBlue,
                numberOfLines: 1,
                paragraphStyle: AppStyle.ParagraphStyle.withProperties(textAlignment: .natural, lineSpacing: 2),
                dateFormat: "HH:mm"
            )

            static let dateNoFileStyle = TextStyle(
                font: AppStyle.Font.withSize(12, weight: .regular),
                color: AppStyle.Color.mainBlue,
                numberOfLines: 1,
                paragraphStyle: AppStyle.ParagraphStyle.withProperties(textAlignment: .natural, lineSpacing: 2),
                dateFormat: "HH:mm"
            )
        }
    }

    // MARK: - Info message
    enum InfoMessageStyle {
        // MARK: - UILabel
        enum Label {
            static let textStyle = TextStyle(
                font: AppStyle.Font.withSize(12.0, weight: .regular),
                color: AppStyle.Color.mainGray,
                numberOfLines: 0,
                paragraphStyle: AppStyle.ParagraphStyle.withProperties(textAlignment: .center, lineSpacing: 2),
                dateFormat: "HH:mm"
            )
        }
    }

    // MARK: - Avatar Message
    enum AvatarMessageStyle {
        // MARK: - UILabel
        enum Label {
            static let textStyle = TextStyle(
                font: AppStyle.Font.withSize(14.0, weight: .regular),
                color: AppStyle.Color.mainGray,
                numberOfLines: 1,
                paragraphStyle: AppStyle.ParagraphStyle.withProperties(textAlignment: .natural, lineSpacing: 2),
                dateFormat: "HH:mm"
            )
        }
    }

    // MARK: - Footer message
    enum FooterMessageStyle {
        // MARK: - UILabel
        enum Label {
            static let textStyle = TextStyle(
                font: AppStyle.Font.withSize(12, weight: .bold),
                color: AppStyle.Color.mainGray,
                numberOfLines: 0,
                paragraphStyle: AppStyle.ParagraphStyle.withProperties(textAlignment: .center, lineSpacing: 2),
                dateFormat: "dd MMMM"
            )
        }
    }

    // MARK: - Placeholder
    enum PlaceholderStyle {
        // MARK: UILabel
        enum Label {
            static let textStyle = TextStyle(
                font: AppStyle.Font.withSize(16, weight: .regular),
                color: AppStyle.Color.lightGray,
                numberOfLines: 1,
                paragraphStyle: AppStyle.ParagraphStyle.withProperties(textAlignment: .left, lineSpacing: 2),
                dateFormat: "HH:mm")
        }
    }
}
