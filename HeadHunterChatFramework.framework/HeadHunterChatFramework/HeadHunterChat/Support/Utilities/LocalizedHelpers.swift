//
//  LocalizedHelpers.swift
//  HeadHunterChat
//
//  Created by 12345 on 08.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

final class LocalizedHelpers {

    static func getLocalizedString(for text: String) -> String {
        guard let bundle = Bundle(identifier: Settings.shared.bundleIdentifier) else {
            return ""
        }
        return NSLocalizedString(text, bundle: bundle, comment: "")
    }

}
