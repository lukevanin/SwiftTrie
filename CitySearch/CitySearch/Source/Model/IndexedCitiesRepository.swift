import Foundation

///
/// A collection of cities.
///
/// Provides access to retrieving cities by their name. Implemented using a `TextIndex` (hence the
/// name), to provide search capability.
///
struct IndexedCitiesRepository: CitiesRepositoryProtocol {
    
    /// List of all cities.
    let cities: [City]
    
    /// Index where the key is the name of a city, and value is the index of the city in the `cities` array.
    let nameIndex: TextIndex
    
    ///
    /// Searches for cities whose name starts with the given prefix.
    ///
    /// - Parameter prefix: Start of the name of the cities to search for.
    /// - Returns: Sequence containing cities.
    ///
    func searchByName(prefix: String) async -> AnySequence<City> {
        await withCheckedContinuation { continuation in
            // Look up the cities matching the given prefix.
            let indices = AnySequence(nameIndex.search(prefix: prefix))
            // Create an iterator that returns the cities for the indices from
            // our search results. We lazily map the sequence so that we can
            // defer iterating the underlying tree until we actually need to.
            let matchingCities = indices.lazy.map { index in
                cities[index]
            }
            let output = AnySequence(matchingCities)
            continuation.resume(returning: output)
        }
    }
}
