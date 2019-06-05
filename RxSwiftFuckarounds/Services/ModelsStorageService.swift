import Foundation
import RxSwift

protocol ModelsStorageServiceProtocol {
    
}

enum ModelsStorageServiceError: Error {
    case db(DBAccessServiceError)
    case deserialization(Error)
}

class ModelsStorageService {
    let dbAccessService: DBAccessServiceProtocol
    
    init(dbAccessService: DBAccessServiceProtocol) {
        self.dbAccessService = dbAccessService
    }
    
    func getModels(by sql: String) -> Single<Result<Model, ModelsStorageServiceError>> {
        return dbAccessService.select(sql: sql)
            .map { result in
                result
                    .mapError { error in
                        .db(error)
                    }
                    .flatMap { data in
                        let model: Model
                        do {
                            model = try BSONDecoder().decode(data)
                        } catch {
                            return .failure(ModelsStorageServiceError.deserialization(error))
                        }
                        return .success(model)
                    }
            }
    }
}

extension ModelsStorageService: ModelsStorageServiceProtocol {
    
}
