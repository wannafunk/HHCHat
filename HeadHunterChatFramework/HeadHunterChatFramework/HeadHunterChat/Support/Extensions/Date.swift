//
//  Date.swift
//  HeadHunterChat
//
//  Created by 12345 on 06.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

extension Date {

    func getDateInFormat(dateFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }

}
