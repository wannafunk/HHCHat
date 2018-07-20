//
//  BaseTableViewHeaderFooterView.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

protocol BaseTableViewHeaderFooterView {

    static func height(withWidth width: CGFloat, model: TableViewHeaderFooterModel?) -> CGFloat
    func update(model: TableViewHeaderFooterModel?)

}
