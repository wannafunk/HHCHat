//
//  ChatHeaderTableViewCellModel.swift
//  HeadHunterChat
//
//  Created by 12345 on 04.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation

final class ChatHeaderTableViewCellModel: TableViewHeaderFooterModel {
    var headerFooterClass: TableHeaderFooterView.Type = ChatTableViewHeaderFooterView.self

    let date: Date

    init(date: Date) {
        self.date = date
    }

}
