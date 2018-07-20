//
//  MessageListenerServiceImpl.swift
//  HeadHunterChat
//
//  Created by 12345 on 19.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation

final class MessageListenerServiceImpl {

    private let networkClient: WebSocketApiService
    private let persistentClient: PersistentMicroService

    private weak var delegate: MessageListenerOutput?

    init(networkClient: WebSocketApiService,
         persistentClient: PersistentMicroService) {
        self.networkClient = networkClient
        self.persistentClient = persistentClient

        networkClient.delegates.addDelegate(self)
    }

}

extension MessageListenerServiceImpl: WebSocketApiServiceDelegate {

    func webSocketApiService(_ service: WebSocketApiService,
                             didRecieveMessage message: DTOMessage,
                             fromEvent: ChatEvent) {
        delegate?.didRecieveMessage(message, fromEvent: fromEvent)
    }

    func webSocketApiService(_ service: WebSocketApiService,
                             didChangeMessage oldMessage: DTOMessage,
                             to newMessage: DTOMessage) {
        delegate?.didRecieveMessage(oldMessage, to: newMessage)
    }

}

// MARK: MessageListenerService
extension MessageListenerServiceImpl: MessageListenerService {

    func setDelegate(_ delegate: MessageListenerOutput) {
        self.delegate = delegate
    }

}
