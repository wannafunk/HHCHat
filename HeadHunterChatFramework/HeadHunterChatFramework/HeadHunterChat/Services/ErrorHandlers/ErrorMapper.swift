//
//  ErrorMapper.swift
//  HeadHunterChat
//
//  Created by Stanislav Kramarenko on 04.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import WebimClientLibrary

//ACCOUNT_BLOCKED
//PROVIDED_VISITOR_FIELDS_EXPIRED
//UNKNOWN
//VISITOR_BANNED
//WRONG_PROVIDED_VISITOR_HASH

enum CommonError: Error {
    case accountBlocked(String)
    case providedVisitorFieldsExpired(String)
    case unknownFatalError(String)
    case visitorBanned(String)
    case wrongProvidedVisitorHash(String)
    case nilAccountName(String)
    case nilLocation(String)
    case invalidRemoteNotificationConfiguration(String)
    case invalidAuthenticationParameters(String)
    case invalidSession(String)
    case invalidThread(String)
    case couldntCreateSession(String)
    case couldntCreateMessageTrack(String)
    case couldntStartSession(String)
    case couldntStopSession(String)
    case couldntStartChat(String)
    case couldntGetLastMessages(String)
    case couldntGetNextMessages(String)
    case couldntSendMessage(String)
    case couldntSendFile(String)
}

extension CommonError {
    public var localizedDescription: String? {
        switch self {
        case .accountBlocked(let description):
            return description
        case .providedVisitorFieldsExpired(let description):
            return description
        case .unknownFatalError(let description):
            return description
        case .visitorBanned(let description):
            return description
        case .wrongProvidedVisitorHash(let description):
            return description
        case .nilAccountName(let description):
            return description
        case .nilLocation(let description):
            return description
        case .invalidRemoteNotificationConfiguration(let description):
            return description
        case .invalidAuthenticationParameters(let description):
            return description
        case .invalidSession(let description):
            return description
        case .invalidThread(let description):
            return description
        case .couldntCreateSession(let description):
            return description
        case .couldntCreateMessageTrack(let description):
            return description
        case .couldntStartSession(let description):
            return description
        case .couldntStopSession(let description):
            return description
        case .couldntStartChat(let description):
            return description
        case .couldntGetLastMessages(let description):
            return description
        case .couldntGetNextMessages(let description):
            return description
        case .couldntSendMessage(let description):
            return description
        case .couldntSendFile(let description):
            return description
        }
    }
}

class ErrorMapper {

}

extension ErrorMapper: WebImErrorMapping {
    func convertFromSessionBuilderError(error: SessionBuilder.SessionBuilderError) -> CommonError {
        switch error {
        case .INVALID_AUTHENTICATION_PARAMETERS:
            return CommonError.invalidAuthenticationParameters(error.localizedDescription)
        case .INVALID_REMOTE_NOTIFICATION_CONFIGURATION:
            return CommonError.invalidRemoteNotificationConfiguration(error.localizedDescription)
        case .NIL_ACCOUNT_NAME:
            return CommonError.nilAccountName(error.localizedDescription)
        case .NIL_LOCATION:
            return CommonError.nilLocation(error.localizedDescription)
        }
    }

    func convertFromAccessError(error: AccessError) -> CommonError {
        switch error {
        case .INVALID_SESSION:
            return CommonError.invalidSession(error.localizedDescription)
        case .INVALID_THREAD:
            return CommonError.invalidThread(error.localizedDescription)
        }
    }

    func convertFromFatalError(error: FatalErrorType) -> CommonError {
        switch error {
        case .ACCOUNT_BLOCKED:
            return CommonError.accountBlocked("Account blocked")
        case .PROVIDED_VISITOR_FIELDS_EXPIRED:
            return CommonError.providedVisitorFieldsExpired("Provided visitor fields expired")
        case .UNKNOWN:
            return CommonError.unknownFatalError("Unknown fatal error")
        case .VISITOR_BANNED:
            return CommonError.visitorBanned("Visitor banned")
        case .WRONG_PROVIDED_VISITOR_HASH:
            return CommonError.wrongProvidedVisitorHash("Wrong provided visitor hash")
        }
    }
}
