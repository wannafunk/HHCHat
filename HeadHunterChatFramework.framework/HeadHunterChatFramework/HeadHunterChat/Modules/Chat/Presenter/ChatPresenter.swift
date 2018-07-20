//
//  ChatPresenter.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation
import UIKit

final class ChatPresenter {

    weak var view: ChatViewInput?
    var interactor: ChatInteractorInput!
    private let router: ChatRouterInput

    private let tableViewModel = ChatTableViewModel()

    private var isLoading: Bool = false

    private var newMessageCount: Int = 0

    init(router: ChatRouterInput) {
        self.router = router
    }

}

// MARK: ChatViewOutput
extension ChatPresenter: ChatViewOutput {

    func viewDidLoad() {
        view?.showLoader()

        interactor.downloadMessages()
    }

    func onMessageSendButtonTap(with text: String) {
        interactor.sendMessage(with: text) { [weak self] (result) in
            switch result {
            case .success(let message):
                print("\(message.messageId)")
            case .failure(let error):
                self?.view?.showAlert(title: TextConstants.errorAlert,
                                      message: error.localizedDescription,
                                      buttonTitle: TextConstants.okAlert,
                                      onDismiss: nil)
                print("\(error.localizedDescription)")
            }
        }
    }

    func onFileSendButtonTap(with fileData: Data) {
        interactor.sendFile(with: fileData,
                            fileName: TextConstants.NotLocalized.jpgFileName,
                            mimeType: TextConstants.NotLocalized.jpgFormat) { [weak self] (result) in
                                switch result {
                                case .success(let message):
                                    print("\(message.messageId)")
                                case .failure(let error):
                                    self?.view?.showAlert(title: TextConstants.errorAlert,
                                                          message: error.localizedDescription,
                                                          buttonTitle: TextConstants.okAlert,
                                                          onDismiss: nil)
                                    print("\(error.localizedDescription)")
                                }
        }

    }

    func downloadNextMessages() {
        if !isLoading {
            view?.showLoader()

            isLoading = true
            interactor.downloadNextMessages()
        }
    }

    func onScrollToBottomButtonTap() {
        newMessageCount = 0
        view?.updateBubbleCountView(for: newMessageCount)
        view?.didScrollToBottom()
    }

    func indexPathsVisibleRows(_ indexPaths: [IndexPath]) {
        if indexPaths.first == IndexPath(row: newMessageCount - 1, section: 0) {
            newMessageCount -= 1
            view?.updateBubbleCountView(for: newMessageCount)
        }
    }

    func onTextViewDidChange(with text: String) {
        interactor.setVisitorTyping(with: text) { [weak self] (result) in
            switch result {
            case .success(let message):
                print("\(message.messageId)")
            case .failure(let error):
                self?.view?.showAlert(title: TextConstants.errorAlert,
                                      message: error.localizedDescription,
                                      buttonTitle: TextConstants.okAlert,
                                      onDismiss: nil)
                print("\(error.localizedDescription)")
            }
        }
    }

}

// MARK: ChatInteractorOutput
extension ChatPresenter: ChatInteractorOutput {

    func didObtainMessages(_ messages: [DTOMessage]) {
        view?.hideLoader()

        tableViewModel.setMessages(messages)
        view?.update(model: tableViewModel)
        view?.setScrollViewDelegate()

        isLoading = messages.count < NumericConstants.limitForMessages

        if isLoading {
            view?.removeSpinnerForTableView()
        }

    }

    func didObtainMessage(_ message: DTOMessage) {
        tableViewModel.addMessage(message)
        view?.updateWithModelProcessing(model: tableViewModel)

        if message.messageType == .operatore || message.messageType == .fileFromOperator {
            newMessageCount += 1
        }

        view?.updateBubbleCountView(for: newMessageCount)
    }

    func didObtainChangeMessage(_ message: DTOMessage) {
        if let indexPath = tableViewModel.getIndexPathUpdateMessage(by: message) {
            view?.reloadRows(at: indexPath)
        }
    }

    func didObtainTypingOperator(_ currentOperator: DTOOperator) {
        tableViewModel.addTypingOperator(currentOperator)
        view?.addHeaderTableView(model: tableViewModel)
    }

    func didDeleteTypingOperator() {
        tableViewModel.deleteTypingOperator()
        view?.removeHeaderTableView(model: tableViewModel)
    }

    func didFailToObtainMessages(error: Error) {
        view?.hideLoader()

        view?.showAlert(title: TextConstants.errorAlert,
                        message: error.localizedDescription,
                        buttonTitle: TextConstants.okAlert,
                        onDismiss: nil)
    }

    func fatalErrorHasOccured(didRecieveError error: CommonError) {
        view?.showAlert(title: TextConstants.errorAlert,
                        message: error.localizedDescription,
                        buttonTitle: TextConstants.okAlert,
                        onDismiss: nil)
    }

}

// MARK: TableViewDataManagerDelegate
extension ChatPresenter: TableViewDataManagerDelegate {

    func didSelectRowAt(_ tableView: UITableView, didSelectRowAt: IndexPath) {
        guard let model = tableViewModel.modelForCell(at: didSelectRowAt) as? ChatTableViewCellModel else {
            return
        }

        if let image = model.message.messageImage {
            DispatchQueue.main.async {
                self.view?.showOpenPhoto(for: image)
            }
        }
    }

}
