//
//  Constants.swift
//  HeadHunterChat
//
//  Created by 12345 on 21.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

// MARK: TextConstants
enum TextConstants {

    // MARK: - NotLocalized
    enum NotLocalized {
        static let jpgFileName = "asset.JPG"
        static let jpgFormat = "JPG"
        static let newLine = "\n"
    }

    // MARK: - Chat
    static let chatNavigationTitle = LocalizedHelpers.getLocalizedString(for: "Help")
    static let placeholderInputTextView = LocalizedHelpers.getLocalizedString(for: "Write your question")
    static let fileIsUnavailable = LocalizedHelpers.getLocalizedString(for: "File is unavailable")
    static let needsPhoto = LocalizedHelpers.getLocalizedString(for: "Needs photo access")
    // MARK: - UIAlertController
    static let сancelAlert = LocalizedHelpers.getLocalizedString(for: "Сancel")
    static let settingsAlert = LocalizedHelpers.getLocalizedString(for: "Settings")
    static let errorAlert = LocalizedHelpers.getLocalizedString(for: "Error")
    static let okAlert = LocalizedHelpers.getLocalizedString(for: "Ok")
    static let cameraAccessAlertText = LocalizedHelpers.getLocalizedString(
        for: "Error occurred while accessing your photos.\nPlease check your settings."
    )
}

// MARK: - NumericConstants
enum NumericConstants {
    static let limitForMessages = 30
    static let loadDistance: CGFloat = 200
    static let animationDurationForKeyboard: TimeInterval = 1
}
