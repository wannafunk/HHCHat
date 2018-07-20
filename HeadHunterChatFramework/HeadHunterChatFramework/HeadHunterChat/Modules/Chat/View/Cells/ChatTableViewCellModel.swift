//
//  ChatTableViewCellModel.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

final class ChatTableViewCellModel: TableViewCellModel {
    var cellClass: TableViewCell.Type = ChatSentTableViewCell.self

    var separatorHidden: Bool = false
    var height: CGFloat = 0

    var message: DTOMessage

    init(message: DTOMessage) {
        self.message = message

        switch message.messageType {
        case .visitor:
            cellClass = ChatSentTableViewCell.self
        case .operatore:
            cellClass = ChatReceivedTableViewCell.self
        case .info:
            cellClass = ChatInfoTableViewCell.self
        case .operatorBusy:
            cellClass = ChatInfoTableViewCell.self
        case .fileFromVisitor:
            cellClass = ChatSentFileTableViewCell.self
        case .fileFromOperator:
            cellClass = ChatReceivedFileTableViewCell.self
        case .actionRequest:
            cellClass = ChatReceivedTableViewCell.self
        case .contactsRequest:
            cellClass = ChatReceivedTableViewCell.self
        case .avatarOperator:
            cellClass = ChatAvatarTableViewCell.self
        }
    }

}
