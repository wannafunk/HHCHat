//
//  MessageNetworkMicroServiceImpl.swift
//  HeadHunterChat
//
//  Created by 12345 on 18.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation
import WebimClientLibrary

final class MessageNetworkMicroServiceImpl {

    private let networkClient: WebSocketApiRequester

    init(networkClient: WebSocketApiRequester) {
        self.networkClient = networkClient
    }

}

// MARK: MessageNetworkMicroService
extension MessageNetworkMicroServiceImpl: MessageNetworkMicroService {

    func sendFile(with fileData: Data,
                  fileName: String,
                  mimeType: String,
                  completion: @escaping (Result<SentMessage>) -> Void) {
        networkClient.sendFile(with: fileData, fileName: fileName, mimeType: mimeType, completion: completion)
    }

    func sendMessage(text: String, completion: @escaping (Result<SentMessage>) -> Void) {
        networkClient.sendMessage(text: text, completion: completion)
    }

    func setVisitorTyping(with text: String, completion: @escaping (Result<SentMessage>) -> Void) {
        networkClient.setVisitorTyping(with: text, completion: completion)
    }

}
