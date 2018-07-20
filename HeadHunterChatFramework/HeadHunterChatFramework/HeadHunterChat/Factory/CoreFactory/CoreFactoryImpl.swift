//
//  CoreFactoryImpl.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 15.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation
import WebimClientLibrary

final class CoreFactoryImpl {

    private let webImInitializer: WebImInitializerImpl
    private let networkService: WebSocketApiServiceImpl
    private let webSocketClient: DefaultWebSocketClient
    private let fatalErrorHandler = FatalErrorServiceImpl(errorMapper: ErrorMapper())

    init() {
        webSocketClient = DefaultWebSocketClient(errorMapper: ErrorMapper())
        webImInitializer = WebImInitializerImpl(errorHandler: fatalErrorHandler,
                                                webImLoger: webSocketClient,
                                                messageListener: webSocketClient)

        webSocketClient.setWebImIntiliazer(webImIntiliazer: webImInitializer)
        networkService = WebSocketApiServiceImpl(webSocketClient: webSocketClient)
    }

}

// MARK: CoreFactory

extension CoreFactoryImpl: CoreFactory {

    func getNetworkClient() -> WebSocketApiService {
        return networkService
    }

    func getNetworkRequester() -> WebSocketApiRequester {
        return networkService
    }

    func getWebImObject() -> WebImInitializer {
        return webImInitializer
    }

    func getFatalErrorHandler() -> FatalErrorService {
        return fatalErrorHandler
    }

    func makeErrorMapper() -> WebImErrorMapping {
        return ErrorMapper()
    }

    func makeWebImPersistentClient() -> WebImPersistent {
        guard let messageTracker = webImInitializer.messageTracker else {
                fatalError("Не получилось создать хранилище ВебИмпа")
        }

        return WebImPersistentService(messageTracker: messageTracker, errorMapper: makeErrorMapper())
    }

}
