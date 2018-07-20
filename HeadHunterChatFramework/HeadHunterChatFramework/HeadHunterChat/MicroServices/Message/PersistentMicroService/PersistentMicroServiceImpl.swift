//
//  PersistentMicroServiceImpl.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 15.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation

final class PersistentMicroServiceImpl {

    private let persistentClient: WebImPersistent

    init(persistentClient: WebImPersistent) {
        self.persistentClient = persistentClient
    }

}

// MARK: PersistentMicroService
extension PersistentMicroServiceImpl: PersistentMicroService {
    func getNextMessages(limit: Int, completion: @escaping (Result<[DTOMessage]>) -> Void) {
        persistentClient.getNextMessages(limit: limit, completion: completion)
    }

    func getLastMessages(limit: Int, completion: @escaping (Result<[DTOMessage]>) -> Void) {
        persistentClient.getLastMessages(limit: limit, completion: completion)
    }

}
