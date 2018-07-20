//
//  DTOMessage.swift
//  HeadHunterChat
//
//  Created by Stanislav Kramarenko on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit
import WebimClientLibrary

enum HHMessageSendStatus {
    case sending
    case sent

    static func convertMessageSendStatus(status: MessageSendStatus) -> HHMessageSendStatus {
        switch status {
        case .SENDING:
            return HHMessageSendStatus.sending
        default:
            return HHMessageSendStatus.sent
        }
    }
}

enum HHMessageType {
    case actionRequest
    case contactsRequest
    case fileFromOperator
    case fileFromVisitor
    case info
    case operatore
    case operatorBusy
    case visitor
    case avatarOperator

    static func convertMessageType(messageType: MessageType) -> HHMessageType {
        switch messageType {
        case .ACTION_REQUEST:
            return .actionRequest
        case .CONTACTS_REQUEST:
            return .contactsRequest
        case .FILE_FROM_OPERATOR:
            return .fileFromOperator
        case .FILE_FROM_VISITOR:
            return .fileFromVisitor
        case .INFO:
            return .info
        case .OPERATOR:
            return .operatore
        case .OPERATOR_BUSY:
            return .operatorBusy
        case .VISITOR:
            return .visitor
        }
    }
}

class DTOMessage {

    var messageData: [String: Any?]?
    var messageId: String
    var operatorID: String?
    var senderAvatarFullURL: URL?
    var senderName: String
    var sendStatus: HHMessageSendStatus
    var messageText: String
    var messageTime: Date
    var messageType: HHMessageType
    var messageFileInfo: MessageAttachment?
    var messageImage: UIImage?
    var webImMessage: Message

    init(fromWebImMessage: Message) {
        webImMessage = fromWebImMessage
        messageData = fromWebImMessage.getData()
        messageId = fromWebImMessage.getID()
        operatorID = fromWebImMessage.getOperatorID()
        senderAvatarFullURL = fromWebImMessage.getSenderAvatarFullURL()
        senderName = fromWebImMessage.getSenderName()
        sendStatus = HHMessageSendStatus.convertMessageSendStatus(status: fromWebImMessage.getSendStatus())
        messageText = fromWebImMessage.getText()
        messageTime = fromWebImMessage.getTime()
        messageType = HHMessageType.convertMessageType(messageType: fromWebImMessage.getType())
        if let attachment = fromWebImMessage.getAttachment() {
            messageFileInfo = attachment
        }
    }

    var isOperatorType: Bool {
        return messageType == .operatore || messageType == .fileFromOperator || messageType == .avatarOperator
    }

}
