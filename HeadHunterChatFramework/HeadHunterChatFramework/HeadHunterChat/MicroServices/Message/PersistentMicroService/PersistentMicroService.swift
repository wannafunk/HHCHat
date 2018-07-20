//
//  PersistentMicroService.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 15.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation

protocol PersistentMicroService {

    func getNextMessages(limit: Int, completion: @escaping (Result<[DTOMessage]>) -> Void)

    func getLastMessages(limit: Int, completion: @escaping (Result<[DTOMessage]>) -> Void)

}
