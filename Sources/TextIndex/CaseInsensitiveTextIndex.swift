import Foundation

import SwiftPack

///
/// Performs case insensitive searches on an underlying `TextIndexProtocol`.
///
/// Wraps a `TextIndexProtocol` allowing queries to match keys regardless of case.
///
/// 1. Keys are converted to uppercase when a value is inserted.
/// 2. Queries are converted to uppercase when a search is performed.
///
public struct CaseInsensitiveTextIndex<Index>: TextIndexProtocol where Index: TextIndexProtocol {
    
    public typealias Value = Index.Value
    
    var index: Index
    
    public init(_ index: Index) {
        self.index = index
    }
    
    ///
    /// Inserts a value into the index using the provided key.
    ///
    mutating public func insert(key: String, value: Value) {
        index.insert(key: transform(key), value: value)
    }

    ///
    /// Searches for a value using the provided index.
    ///
    /// - Parameter prefix: The case insensitive prefix of the values to search for.
    /// - Returns: Values whose key starts with the given prefix.
    ///
    public func search<S>(prefix: S) -> TextIndexSearchResult<Value> where S : StringProtocol {
        index.search(prefix: transform(prefix))
    }
    
    ///
    /// Transforms the given key or prefix into a canonical form where charaters are equivalent regardless
    /// of case.
    ///
    private func transform<S>(_ input: S) -> String where S: StringProtocol {
        input.uppercased()
    }
}

extension CaseInsensitiveTextIndex: Equatable where Index: Equatable {
    
}


// MARK: Data Codable Conformance


extension CaseInsensitiveTextIndex: DataCodable where Index: DataCodable {
    
    public func encode(encoder: DataEncoder) {
        index.encode(encoder: encoder)
    }
    
    public init(decoder: DataDecoder) throws {
        self.init(try Index(decoder: decoder))
    }
}
