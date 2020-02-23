import Foundation

extension Client {
    @discardableResult
    public func listRepositories(completion: @escaping (Result<[Repository], Error>) -> Void)
        -> URLSessionDataTask
    {
        graphQL(ListQuery(), completion: completion)
    }
}
