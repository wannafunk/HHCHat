//
//  FatalErrorHandlers.swift
//  HeadHunterChat
//
//  Created by Stanislav Kramarenko on 04.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import WebimClientLibrary

class FatalErrorServiceImpl: FatalErrorService {
    let errorMapper: WebImErrorMapping
    var delegates = MulticastDelegate<FatalErrorOutput>()

    init(errorMapper: WebImErrorMapping) {
        self.errorMapper = errorMapper
    }

    func setDelegate(_ delegate: FatalErrorOutput) {
        delegates.addDelegate(delegate)
    }

}

extension FatalErrorServiceImpl: FatalErrorHandler {

    func on(error: WebimError) {
        let commonError = errorMapper.convertFromFatalError(error: error.getErrorType())
        delegates.invokeDelegates { (delegate) in
            delegate.fatalErrorHasOccured(didRecieveError: commonError)
        }
    }

}
