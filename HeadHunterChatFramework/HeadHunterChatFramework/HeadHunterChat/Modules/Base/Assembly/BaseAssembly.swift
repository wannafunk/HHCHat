//
//  BaseAssembly.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation

class BaseAssembly {

    let assemblyFactory: AssemblyFactory
    let serviceFactory: ServiceFactory

    init(assemblyFactory: AssemblyFactory,
         serviceFactory: ServiceFactory) {
        self.assemblyFactory = assemblyFactory
        self.serviceFactory = serviceFactory
    }

}
