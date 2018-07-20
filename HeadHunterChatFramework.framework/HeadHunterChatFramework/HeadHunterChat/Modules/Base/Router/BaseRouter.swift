//
//  BaseRouter.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

class BaseRouter {

    let assemblyFactory: AssemblyFactory

    weak var navigationController: UINavigationController?

    init(assemblyFactory: AssemblyFactory, navigationController: UINavigationController? = nil) {
        self.assemblyFactory = assemblyFactory
        self.navigationController = navigationController
    }

}
