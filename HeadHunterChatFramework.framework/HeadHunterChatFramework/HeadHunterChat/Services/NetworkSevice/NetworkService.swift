//
//  NetworkService.swift
//  HeadHunterChat
//
//  Created by 12345 on 19.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation
import WebimClientLibrary

protocol NetworkService {

    func obtainMessages(forUserId userId: String, completion: @escaping (Result<[DTOMessage]>) -> Void)

    func sendMessage(with text: String)
    func sendFile(with fileData: Data, fileName: String, mimeType: String, completionHandler: SendFileCompletionHandler)

}
