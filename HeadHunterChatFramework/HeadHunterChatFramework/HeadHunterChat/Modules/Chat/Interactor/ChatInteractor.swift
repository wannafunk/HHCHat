//
//  ChatInteractor.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation
import WebimClientLibrary

final class ChatInteractor {

    private weak var output: ChatInteractorOutput?

    private let messageService: MessageService
    private let messageListener: MessageListenerService
    private let operatorStateService: OperatorStateService
    private let fatalErrorService: FatalErrorService

    init(messageService: MessageService,
         messageListener: MessageListenerService,
         output: ChatInteractorOutput,
         operatorStateService: OperatorStateService,
         fatalErrorService: FatalErrorService) {
        self.messageService = messageService
        self.messageListener = messageListener
        self.operatorStateService = operatorStateService
        self.fatalErrorService = fatalErrorService

        self.output = output

        messageListener.setDelegate(self)
        operatorStateService.setDelegate(self)
        fatalErrorService.setDelegate(self)
    }

}

// MARK: VacancyInteractorInput
extension ChatInteractor: ChatInteractorInput {

    func sendMessage(with text: String, completion: @escaping (Result<SentMessage>) -> Void) {
        messageService.sendMessage(text: text, completion: completion)
    }

    func sendFile(with fileData: Data,
                  fileName: String,
                  mimeType: String,
                  completion: @escaping (Result<SentMessage>) -> Void) {
        messageService.sendFile(with: fileData, fileName: fileName, mimeType: mimeType, completion: completion)
    }

    func downloadMessages() {
        messageService.getLastMessages(limit: NumericConstants.limitForMessages) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let messages):
                    self?.output?.didObtainMessages(messages.reversed())
                case .failure(let error):
                    self?.output?.didFailToObtainMessages(error: error)
                    print("\(error.localizedDescription)")
                }
            }
        }
    }

    func setVisitorTyping(with text: String, completion: @escaping (Result<SentMessage>) -> Void) {
        messageService.setVisitorTyping(with: text, completion: completion)
    }

    func downloadNextMessages() {
        messageService.getNextMessages(limit: NumericConstants.limitForMessages) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let messages):
                    self?.output?.didObtainMessages(messages.reversed())
                case .failure(let error):
                    self?.output?.didFailToObtainMessages(error: error)
                    print("\(error.localizedDescription)")
                }
            }
        }
    }

}

// MARK: - MessageListenerOutput
extension ChatInteractor: MessageListenerOutput {

    func didRecieveMessage(_ message: DTOMessage, fromEvent: ChatEvent) {
        DispatchQueue.main.async {
            self.output?.didObtainMessage(message)
        }
    }

    func didRecieveMessage(_ oldMessage: DTOMessage, to newMessage: DTOMessage) {
        DispatchQueue.main.async {
            self.output?.didObtainChangeMessage(newMessage)
        }
    }

}

// MARK: - OperatorListenerOutput
extension ChatInteractor: OperatorStateListenerOutput {

    func operatorTypingStateChanged(isTyping: Bool) {
        DispatchQueue.main.async {
            if let currentOperator = self.operatorStateService.getCurrentOperator(), isTyping {
                guard let dtoOperator = DTOOperator(fromWebImOperator: currentOperator) else {
                    return
                }

                self.output?.didObtainTypingOperator(dtoOperator)
            } else {
                self.output?.didDeleteTypingOperator()
            }
        }
    }

}

// MARK: - FatalErrorOutput
extension ChatInteractor: FatalErrorOutput {

    func fatalErrorHasOccured(didRecieveError error: CommonError) {
        DispatchQueue.main.async {
            self.output?.fatalErrorHasOccured(didRecieveError: error)
        }
    }

}
