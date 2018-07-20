//
//  ServiceFactoryImpl.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 15.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation

final class ServiceFactoryImpl {

    private let coreFactory: CoreFactory

    init(coreFactory: CoreFactory) {
        self.coreFactory = coreFactory
    }

    // MARK: Utility methods
    private func makePersistentMessageMicroService() -> PersistentMicroService {
        return PersistentMicroServiceImpl(persistentClient: coreFactory.makeWebImPersistentClient())
    }

}

// MARK: ServiceFactory
extension ServiceFactoryImpl: ServiceFactory {

    func getFatalErrorHandler() -> FatalErrorService {
        return coreFactory.getFatalErrorHandler()
    }

    func makeMessageService() -> MessageService {
        let networkMessageMicroService = MessageNetworkMicroServiceImpl(
            networkClient: coreFactory.getNetworkRequester()
        )

        return MessageServiceImpl(networkClient: networkMessageMicroService,
                                  persistentClient: makePersistentMessageMicroService())
    }

    func makeMessageListenerService() -> MessageListenerService {
        let networkService = coreFactory.getNetworkClient()

        return MessageListenerServiceImpl(networkClient: networkService,
                                          persistentClient: makePersistentMessageMicroService())
    }

    func makeOperatorListenerService() -> OperatorStateService {
        let webImObject = coreFactory.getWebImObject()

        guard let messageStream = webImObject.messageStream else {
            fatalError("Не удается получить объект messageStream")
        }
        let operatorStateService = OperatorStateServiceImpl(messageStream: messageStream)

        return operatorStateService
    }

    func makeFatalErrorService() -> FatalErrorService {
        return coreFactory.getFatalErrorHandler()
    }

}
