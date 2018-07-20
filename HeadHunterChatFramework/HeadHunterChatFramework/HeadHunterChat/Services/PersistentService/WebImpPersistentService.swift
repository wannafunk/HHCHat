//
//  WebImPersistentService.swift
//  HeadHunterChat
//
//  Created by Stanislav Kramarenko on 21.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit
import WebimClientLibrary

protocol WebImPersistent {

    func getLastMessages(limit: Int, completion: @escaping (Result<[DTOMessage]>) -> Void)
    func getNextMessages(limit: Int, completion: @escaping (Result<[DTOMessage]>) -> Void)

}

final class WebImPersistentService {

    private let messageTracker: MessageTracker
    private let errorMapper: WebImErrorMapping

    init(messageTracker: MessageTracker, errorMapper: WebImErrorMapping) {
        self.messageTracker = messageTracker
        self.errorMapper = errorMapper
    }

}

// MARK: - WebImPersistent
extension WebImPersistentService: WebImPersistent {

    func getLastMessages(limit: Int, completion: @escaping (Result<[DTOMessage]>) -> Void) {
        do {
            try messageTracker.getLastMessages(byLimit: limit, completion: { messages in
                let dtoMessages = messages.compactMap { DTOMessage(fromWebImMessage: $0) }

                completion(.success(dtoMessages))
            })
        } catch let error as AccessError {
            let commonError = errorMapper.convertFromAccessError(error: error)
            completion(.failure(commonError))
        } catch {
            let commonError = CommonError.couldntGetLastMessages(error.localizedDescription)
            completion(.failure(commonError))
        }
    }

    func getNextMessages(limit: Int, completion: @escaping (Result<[DTOMessage]>) -> Void) {
        do {
            try messageTracker.getNextMessages(byLimit: limit, completion: { messages in
                let dtoMessages = messages.compactMap { DTOMessage(fromWebImMessage: $0) }

                completion(.success(dtoMessages))
            })
        } catch let error as AccessError {
            let commonError = errorMapper.convertFromAccessError(error: error)
            completion(.failure(commonError))
        } catch {
            let commonError = CommonError.couldntGetNextMessages(error.localizedDescription)
            completion(.failure(commonError))
        }
    }

}
