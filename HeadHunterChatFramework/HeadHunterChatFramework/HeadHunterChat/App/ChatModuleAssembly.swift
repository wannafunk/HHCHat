//
//  StartViewController.swift
//  HeadHunterChatFramework
//
//  Created by Harbros 3 on 19.07.2018.
//  Copyright © 2018 HH. All rights reserved.
//

import UIKit

public class ChatModuleAssembly {
    
    public func makeChatModule(for userId: String, navigationController: UINavigationController) -> ChatModule {
        let coreFactory = CoreFactoryImpl()
        let serviceFactory = ServiceFactoryImpl(coreFactory: coreFactory)
        let assemblyFactory = AssemblyFactoryImpl(serviceFactory: serviceFactory)
        
        let chatModule = assemblyFactory.makeChatAssembly().module(for: userId,
                                                                   navigationController: navigationController)
        
        return chatModule
    }
}
