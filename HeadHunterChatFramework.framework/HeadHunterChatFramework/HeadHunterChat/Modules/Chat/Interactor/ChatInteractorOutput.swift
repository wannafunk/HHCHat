//
//  ChatInteractorOutput.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation

protocol ChatInteractorOutput: class {

    func didObtainMessages(_ messages: [DTOMessage])
    func didObtainMessage(_ message: DTOMessage)
    func didObtainChangeMessage(_ message: DTOMessage)

    func didObtainTypingOperator(_ currentOperator: DTOOperator)
    func didDeleteTypingOperator()

    func didFailToObtainMessages(error: Error)

    func fatalErrorHasOccured(didRecieveError error: CommonError)

}
