//
//  TableViewHeaderFooterModel.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

typealias TableHeaderFooterView = (UITableViewHeaderFooterView & BaseTableViewHeaderFooterView)

protocol TableViewHeaderFooterModel {

    var headerFooterClass: TableHeaderFooterView.Type { get }
    var headerFooterReuseIdentifier: String { get }

}

extension TableViewHeaderFooterModel {

    var headerFooterReuseIdentifier: String {
        return String(describing: headerFooterClass) + "ReuseIdentifier"
    }

}
