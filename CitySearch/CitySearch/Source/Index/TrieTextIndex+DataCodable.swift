import Foundation

// MARK: DataCodable conformance


extension TrieTextIndex: DataCodable where Value: DataCodable {
    init(decoder: DataDecoder) throws {
        self.init(
            root: try Node(decoder: decoder)
        )
    }
    
    func encode(encoder: DataEncoder) {
        root.encode(encoder: encoder)
    }
}


extension TrieTextIndex.Node: DataCodable where Value: DataCodable {
    
    init(decoder: DataDecoder) throws {
        self = TrieTextIndex.Node(
            count: Int(try VarUInt64(decoder: decoder).value),
            values: try [Value](decoder: decoder),
            characters: try [TrieTextIndex.CodeUnit](decoder: decoder),
            childNodes: try [TrieTextIndex.CodeUnit : TrieTextIndex.Node](decoder: decoder)
        )
    }
    
    func encode(encoder: DataEncoder) {
        VarUInt64(count).encode(encoder: encoder)
        values.encode(encoder: encoder)
        characters.encode(encoder: encoder)
        childNodes.encode(encoder: encoder)
    }
}


extension TrieTextIndex.CodeUnit: DataCodable {
    
    init(decoder: DataDecoder) throws {
        let scalar = try VarUInt64(decoder: decoder)
        #warning("TODO: Safe unwrap")
        let unicodeScalar = UnicodeScalar(UInt32(scalar.value))!
        self.init(unicodeScalar: unicodeScalar)
    }
    
    func encode(encoder: DataEncoder) {
        VarUInt64(scalarValue).encode(encoder: encoder)
    }
}
