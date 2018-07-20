//
//  MessageService.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 15.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation
import WebimClientLibrary

protocol MessageService {

    func sendMessage(text: String, completion: @escaping (Result<SentMessage>) -> Void)

    func sendFile(with fileData: Data,
                  fileName: String,
                  mimeType: String,
                  completion: @escaping (Result<SentMessage>) -> Void)
    func setVisitorTyping(with text: String, completion: @escaping (Result<SentMessage>) -> Void)

    func getNextMessages(limit: Int, completion: @escaping (Result<[DTOMessage]>) -> Void)

    func getLastMessages(limit: Int, completion: @escaping (Result<[DTOMessage]>) -> Void)

}
