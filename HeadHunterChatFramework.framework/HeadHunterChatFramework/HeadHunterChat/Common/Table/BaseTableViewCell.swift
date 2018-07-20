//
//  BaseTableViewCell.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

protocol BaseTableViewCell {

    static func heightFor(width: CGFloat, model: TableViewCellModel?) -> CGFloat
    func update(with model: TableViewCellModel?)

}
