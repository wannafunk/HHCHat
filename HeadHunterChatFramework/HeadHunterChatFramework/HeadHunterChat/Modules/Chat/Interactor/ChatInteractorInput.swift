//
//  ChatInteractorInput.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation
import UIKit

struct SentMessage {

    var messageId: String

}

protocol ChatInteractorInput {

    func sendMessage(with text: String, completion: @escaping (Result<SentMessage>) -> Void)
    func sendFile(with fileData: Data,
                  fileName: String,
                  mimeType: String,
                  completion: @escaping (Result<SentMessage>) -> Void)
    func setVisitorTyping(with text: String, completion: @escaping (Result<SentMessage>) -> Void)

    func downloadMessages()
    func downloadNextMessages()

}
