//
//  MessageListenerService.swift
//  HeadHunterChat
//
//  Created by 12345 on 19.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation

protocol MessageListenerService {

    func setDelegate(_ delegate: MessageListenerOutput)

}

protocol MessageListenerOutput: class {

    func didRecieveMessage(_ message: DTOMessage, fromEvent: ChatEvent)
    func didRecieveMessage(_ oldMessage: DTOMessage, to newMessage: DTOMessage)

}
