//
//  ServiceFactory.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 15.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation

protocol ServiceFactory {

    func getFatalErrorHandler() -> FatalErrorService
    func makeMessageService() -> MessageService
    func makeMessageListenerService() -> MessageListenerService
    func makeOperatorListenerService() -> OperatorStateService

}
