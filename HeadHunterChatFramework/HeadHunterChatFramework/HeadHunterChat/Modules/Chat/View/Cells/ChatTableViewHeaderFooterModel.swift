//
//  ChatTableViewHeaderFooterModel.swift
//  HeadHunterChat
//
//  Created by 12345 on 04.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation

final class ChatTableViewHeaderFooterModel: TableViewHeaderFooterModel {
    var headerFooterClass: TableHeaderFooterView.Type = DateTableViewHeaderFooterView.self

    var date: Date

    init(date: Date) {
        self.date = date
    }

}
