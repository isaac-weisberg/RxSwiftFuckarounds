import RxSwift
import Foundation

protocol JSONDownloaderServiceProtocol {
    
}

enum JSONDownloaderServiceError: Error {
    case download(FileDownloaderServiceError)
    case deserialization(Error)
}

class JSONDownloaderService {
    let fileDownloader: FileDownloaderServiceProtocol
    
    init(fileDownloader: FileDownloaderServiceProtocol) {
        self.fileDownloader = fileDownloader
    }
    
    func download<Object: Decodable>(from url: URL) -> Single<Object> {
        return fileDownloader.download(url: url)
            .catchError { error in
                assert(error is FileDownloaderServiceError, "Expecting this one to be the file downloaders")
                let error = error as! FileDownloaderServiceError
                return .error(JSONDownloaderServiceError.download(error))
            }
            .map { data in
                let object: Object
                do {
                    object = try JSONDecoder().decode(Object.self, from: data)
                } catch {
                    throw JSONDownloaderServiceError.deserialization(error)
                }
                return object
            }
    }
}

extension JSONDownloaderService: JSONDownloaderServiceProtocol {
    
}
