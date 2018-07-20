import Foundation

enum WebSocketApiServiceError: Swift.Error {
    case objectMapping
    case unsupportedMethod
    case badRequest
    case timeout
    case serverError

//    var errorDescription: ErrorDescription {
//        switch self {
//        case .objectMapping:     return ErrorDescription(title: "Error", message: "objectMapping")
//        case .unsupportedMethod: return ErrorDescription(title: "Error", message: "unsupportedMethod")
//        case .badRequest:        return ErrorDescription(title: "Error", message: "badRequest")
//        case .timeout:           return ErrorDescription(title: "Error", message: "timeout")
//        case .serverError:       return ErrorDescription(title: "Error", message: "serverError")
//        }
//    }
}
