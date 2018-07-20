//
//  WebimpSettings.swift
//  HeadHunterChat
//
//  Created by Stanislav Kramarenko on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

final class Settings {

    // MARK: - Constants 
    private enum DefaultSettings: String {
        case accountName = "testhhru"
        case location = "mobile"
        case pageTitle = "iOS demo app"
    }

    let userDefaultsName = "settings"

    private enum UserDefaultsKey: String {
        case accountName = "testhhru"
        case colorScheme = "color_scheme"
        case location = "iOS"
        case pageTitle = "page_title"
    }

    // MARK: - Properties
    static let shared = Settings()

    var accountName: String
    var location: String
    var pageTitle: String

    let bundleIdentifier = "-.HeadHunterChat"

    // MARK: - Initialization
    private init() {
        if let settings = UserDefaults.standard.object(forKey: userDefaultsName) as? [String: String] {
            self.accountName = settings[UserDefaultsKey.accountName.rawValue] ?? DefaultSettings.accountName.rawValue
            self.location = settings[UserDefaultsKey.location.rawValue] ?? DefaultSettings.location.rawValue
            self.pageTitle = settings[UserDefaultsKey.pageTitle.rawValue] ?? DefaultSettings.pageTitle.rawValue
        } else {
            self.accountName = DefaultSettings.accountName.rawValue
            self.location = DefaultSettings.location.rawValue
            self.pageTitle = DefaultSettings.pageTitle.rawValue
        }
    }

    // MARK: - Methods
    func save() {
        let settings = [UserDefaultsKey.accountName.rawValue: accountName,
                        UserDefaultsKey.location.rawValue: location,
                        UserDefaultsKey.pageTitle.rawValue: pageTitle]
        UserDefaults.standard.set(settings,
                                  forKey: userDefaultsName)
    }

}
