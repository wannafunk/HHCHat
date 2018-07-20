//
//  AssemblyFactoryIImpl.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation

final class AssemblyFactoryImpl {

    private let serviceFactory: ServiceFactory

    init(serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }

}

// MARK: AssemblyFactory
extension AssemblyFactoryImpl: AssemblyFactory {

    func makeChatAssembly() -> ChatAssembly {
        return ChatAssemblyImpl(assemblyFactory: self, serviceFactory: serviceFactory)
    }

}
