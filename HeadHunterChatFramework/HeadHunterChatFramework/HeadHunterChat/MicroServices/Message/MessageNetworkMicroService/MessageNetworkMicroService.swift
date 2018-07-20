//
//  MessageNetworkMicroService.swift
//  HeadHunterChat
//
//  Created by 12345 on 18.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation

protocol MessageNetworkMicroService {

    func sendMessage(text: String, completion: @escaping (Result<SentMessage>) -> Void)
    func sendFile(with fileData: Data,
                  fileName: String,
                  mimeType: String,
                  completion: @escaping (Result<SentMessage>) -> Void)
    func setVisitorTyping(with text: String, completion: @escaping (Result<SentMessage>) -> Void)
}
