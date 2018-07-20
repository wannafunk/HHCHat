//
//  ChatAssemblyImpl.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

final class ChatAssemblyImpl: BaseAssembly { }

// MARK: ChatAssembly
extension ChatAssemblyImpl: ChatAssembly {

    func module(for userId: String, navigationController: UINavigationController) -> ChatModule {
        let router = ChatRouter(assemblyFactory: assemblyFactory, navigationController: navigationController)
        let presenter = ChatPresenter(router: router)
        let tableViewDataManager = TableViewDataManager(delegate: presenter)
        let viewController = ChatViewController(output: presenter, tableViewDataManager: tableViewDataManager)
        let interactor = ChatInteractor(
            messageService: serviceFactory.makeMessageService(),
            messageListener: serviceFactory.makeMessageListenerService(),
            output: presenter,
            operatorStateService: serviceFactory.makeOperatorListenerService(),
            fatalErrorService: serviceFactory.getFatalErrorHandler()
        )

        presenter.interactor = interactor
        presenter.view = viewController

        return ChatModule(viewController: viewController)
    }

}
