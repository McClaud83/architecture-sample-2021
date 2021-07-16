import Foundation
import Constants
import RxSwift
import Moya

enum ErrorHandler {
    /// Преобразовывает пойманную ошибку в ошибку типа `Domain.Error`.
    static func handleError<T>(error: Swift.Error) -> Single<T> {
        switch error {
        case is Error:
            return Single.error(error)

        case let error as MoyaError:
            let error = ErrorHandler.mapMoyaError(error)
            return Single.error(error)

        default:
            return Single.error(Errors.CommonError.swiftError(error))
        }
    }
    
    /// Мапим ошибку Moya
    private static func mapMoyaError(_ error: MoyaError) -> Error {
        switch error {
        case .encodableMapping, .objectMapping, .jsonMapping, .stringMapping:
            return Errors.Network.badResponse

        case .underlying(let error, _):
            return ErrorHandler.mapUnderlying(error)

        case .statusCode(let response) where response.statusCode == 401:
            return Errors.Network.unauthorized
            
        default:
            return Errors.Network.networkError(error.localizedDescription)
        }
    }
    
    /// Мапим ошибку Underlying error
    private static func mapUnderlying(_ error: Swift.Error) -> Error {
        if let asAFError = error.asAFError,
           asAFError.isSessionTaskError
        {
            return Errors.Network.noInternet
        }

        if (error as NSError).domain == NSURLErrorDomain {
            if [NSURLErrorCannotConnectToHost, NSURLErrorNetworkConnectionLost].contains((error as NSError).code) {
                return Errors.Network.serverUnavailable
            }
            return Errors.Network.networkError(error.localizedDescription)
        }

        if (error as NSError).domain == kCFErrorDomainCFNetwork as String {
            return Errors.Network.serverUnavailable
        }

        return Errors.CommonError.systemError(error.localizedDescription)
    }
}
