//
//  TableViewScrollPosition.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

enum TableViewScrollPosition {
    case none
    case top
    case middle
    case bottom
}

extension TableViewScrollPosition {

    var uiTableViewScrollPosition: UITableViewScrollPosition {
        switch self {
        case .none: return .none
        case .top: return .top
        case .middle: return .middle
        case .bottom: return .bottom
        }
    }

}
