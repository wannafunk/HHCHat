//
//  ChatAssembly.swift
//  HeadHunterChat
//
//  Created by Brothers Harhun on 14.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

protocol ChatAssembly {

    func module(for userId: String, navigationController: UINavigationController) -> ChatModule

}
