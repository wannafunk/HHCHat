//
//  OperatorStateListenerServiceImpl.swift
//  HeadHunterChat
//
//  Created by Stanislav Kramarenko on 06.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import WebimClientLibrary

class OperatorStateServiceImpl: OperatorStateService {
    weak var delegate: OperatorStateListenerOutput?
    let messageStream: MessageStream

    init(messageStream: MessageStream) {
        self.messageStream = messageStream
        messageStream.set(operatorTypingListener: self)
    }

    func setDelegate(_ delegate: OperatorStateListenerOutput) {
        self.delegate = delegate
    }

    func getCurrentOperator() -> Operator? {
        return messageStream.getCurrentOperator()
    }

}

extension OperatorStateServiceImpl: OperatorTypingListener {

    func onOperatorTypingStateChanged(isTyping: Bool) {
        delegate?.operatorTypingStateChanged(isTyping: isTyping)
    }

}
