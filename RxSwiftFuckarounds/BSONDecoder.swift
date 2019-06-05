import Foundation

class BSONDecoder: Decoder {
    var codingPath: [CodingKey] = []
    
    var userInfo: [CodingUserInfoKey : Any] = [:]
    
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        fatalError("NOT IMPL")
    }
    
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        fatalError("NOT IMPL")
    }
    
    func singleValueContainer() throws -> SingleValueDecodingContainer {
        fatalError("NOT IMPL")
    }
    
    init() {
        
    }
    
    func decode<Object>(_ data: Data) throws -> Object {
        fatalError("NOT IMPL")
    }
}
