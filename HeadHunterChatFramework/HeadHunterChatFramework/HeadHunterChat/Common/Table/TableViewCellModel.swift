//
//  TableViewCellModel.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation
import UIKit

typealias TableViewCell = UITableViewCell & BaseTableViewCell

protocol TableViewCellModel: class {

    var cellClass: TableViewCell.Type { get }
    var cellReuseIdentifier: String { get }
    var separatorHidden: Bool { get set }
    var height: CGFloat { get set }

}

extension TableViewCellModel {

    var cellReuseIdentifier: String {
        return String(describing: cellClass) + "ReuseIdentifier"
    }

}
