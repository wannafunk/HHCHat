//
//  FatalErrorService.swift
//  HeadHunterChat
//
//  Created by Stanislav Kramarenko on 06.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit

protocol FatalErrorService: class {
    var delegates: MulticastDelegate<FatalErrorOutput> { get }

    func setDelegate(_ delegate: FatalErrorOutput)

}

protocol FatalErrorOutput: class {

    func fatalErrorHasOccured(didRecieveError error: CommonError)

}
