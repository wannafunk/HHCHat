//
//  ErrorProtocols.swift
//  HeadHunterChat
//
//  Created by Stanislav Kramarenko on 04.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import WebimClientLibrary

protocol WebImErrorMapping {
    func convertFromSessionBuilderError(error: SessionBuilder.SessionBuilderError) -> CommonError
    func convertFromAccessError(error: AccessError) -> CommonError
    func convertFromFatalError(error: FatalErrorType) -> CommonError
}
