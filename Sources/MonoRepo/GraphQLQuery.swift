import Foundation

public enum GraphQLError: Error {
    case missingData
    case failedToParse
    case unknown(Error)
}

public protocol GraphQLQuery {
    associatedtype Output
    var query: String { get }
    func transform(_ data: Data) throws -> Output
}
