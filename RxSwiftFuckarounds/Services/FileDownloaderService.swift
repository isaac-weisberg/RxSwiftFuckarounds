import Foundation
import RxSwift

protocol FileDownloaderServiceProtocol {
    func download(url: URL) -> Single<Data>
}

enum FileDownloaderServiceError: Error {
    case download(Error)
}

class FileDownloaderService {
    func download(url: URL) -> Single<Data> {
        return Single.deferred {
            let data: Data
            do {
                data = try Data(contentsOf: url)
            } catch {
                return .error(FileDownloaderServiceError.download(error))
            }
            return .just(data)
        }
    }
}

extension FileDownloaderService: FileDownloaderServiceProtocol {
    
}
