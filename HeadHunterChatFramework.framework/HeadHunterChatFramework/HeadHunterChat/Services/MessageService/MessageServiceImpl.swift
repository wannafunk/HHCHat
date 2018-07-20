//
//  MessageServiceImpl.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 15.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation
import WebimClientLibrary

final class MessageServiceImpl {

    private let networkClient: MessageNetworkMicroService
    private let persistentClient: PersistentMicroService

    init(networkClient: MessageNetworkMicroService,
         persistentClient: PersistentMicroService) {
        self.networkClient = networkClient
        self.persistentClient = persistentClient
    }

}

// MARK: MessageService
extension MessageServiceImpl: MessageService {

    func getNextMessages(limit: Int, completion: @escaping (Result<[DTOMessage]>) -> Void) {
        persistentClient.getNextMessages(limit: limit,
                                         completion: completion)
    }

    func getLastMessages(limit: Int, completion: @escaping (Result<[DTOMessage]>) -> Void) {
        persistentClient.getLastMessages(limit: limit,
                                         completion: completion)
    }

    func sendMessage(text: String, completion: @escaping (Result<SentMessage>) -> Void) {
        networkClient.sendMessage(text: text, completion: completion)
    }

    func sendFile(with fileData: Data,
                  fileName: String,
                  mimeType: String,
                  completion: @escaping (Result<SentMessage>) -> Void) {

        networkClient.sendFile(with: fileData,
                               fileName: fileName,
                               mimeType: mimeType,
                               completion: completion)
    }

    func setVisitorTyping(with text: String, completion: @escaping (Result<SentMessage>) -> Void) {
        networkClient.setVisitorTyping(with: text, completion: completion)
    }

}
