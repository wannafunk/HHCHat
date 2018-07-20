//
//  Message+CustomMessageProtocolExtension.swift
//  HeadHunterChat
//
//  Created by Stanislav Kramarenko on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

protocol CommonMessageProtocol {

    var messageData: [String: Any?]? { get set }
    var messageId: String { get set }
    var operatorID: String? { get set }
    var senderAvatarFullURL: URL? { get set }
    var senderName: String { get set }
    var sendStatus: HHMessageSendStatus { get set }
    var messageText: String { get set }
    var messageTime: Date { get set }
    var messageType: HHMessageType { get set }

}
