import Foundation
import RxSwift

protocol DBAccessServiceProtocol {
    func select(sql: String) -> Single<Result<Data, DBAccessServiceError>>
}

enum DBAccessServiceError: Error {
    case deserialization(Error)
    case `internal`(Error)
    case serialization(Error)
}

// Implementation deliberately skipped
