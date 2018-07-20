//
//  ChatTableViewHeaderFooterViewModel.swift
//  HeadHunterChat
//
//  Created by 12345 on 09.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation

enum TableHeaderFooterViewType {
    case header
    case footer
}

final class ChatTableViewHeaderFooterViewModel: TableViewHeaderFooterModel {
    var headerFooterClass: TableHeaderFooterView.Type = DateTableViewHeaderFooterView.self

    let date: Date
    let currentOperator: DTOOperator?

    init(date: Date, type: TableHeaderFooterViewType, currentOperator: DTOOperator? = nil) {
        self.date = date
        self.currentOperator = currentOperator

        switch type {
        case .header:
            headerFooterClass = ChatInputMessageHeaderFooterView.self
        case .footer:
            headerFooterClass = DateTableViewHeaderFooterView.self
        }
    }

}
