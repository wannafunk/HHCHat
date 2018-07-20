//
//  CoreFactory.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 15.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation

protocol CoreFactory {

    func getNetworkClient() -> WebSocketApiService
    func getNetworkRequester() -> WebSocketApiRequester
    func getWebImObject() -> WebImInitializer
    func getFatalErrorHandler() -> FatalErrorService
    func makeWebImPersistentClient() -> WebImPersistent

}
