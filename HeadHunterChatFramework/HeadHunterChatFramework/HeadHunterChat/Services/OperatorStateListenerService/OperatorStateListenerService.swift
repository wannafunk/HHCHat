//
//  OperatorStateListenerService.swift
//  HeadHunterChat
//
//  Created by Stanislav Kramarenko on 06.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//
import WebimClientLibrary

protocol OperatorStateService: class {

    func setDelegate(_ delegate: OperatorStateListenerOutput)
    func getCurrentOperator() -> Operator?

}

protocol OperatorStateListenerOutput: class {

    func operatorTypingStateChanged(isTyping: Bool)

}
