import Foundation

@testable import TextIndex

struct MockTextIndex<Value>: TextIndexProtocol {
    
    var mockInsert: ((_ key: String, _ value: Value) -> Void)!
    var mockSearch: ((_ prefix: String) -> [Value])!
    
    func insert(key: String, value: Value) {
        mockInsert(key, value)
    }
    
    func search<S>(prefix: S) -> TextIndexSearchResult<Value> where S : StringProtocol {
        let result = mockSearch(String(prefix))
        return TextIndexSearchResult(
            count: result.count,
            iterator: AnyIterator(result.makeIterator())
        )
    }
}
