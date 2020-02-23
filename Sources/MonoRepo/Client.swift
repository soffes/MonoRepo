import Foundation

public final class Client {

    // MARK: - Properties

    private let accessToken: String
    private let baseURL: URL
    private let session: URLSession

    // MARK: - Initializers

    public init(accessToken: String, baseURL: URL = URL(string: "https://api.github.com/")!, session: URLSession = .shared) {
        self.accessToken = accessToken
        self.baseURL = baseURL
        self.session = session
    }

    // MARK: - Querying

    @discardableResult
    public func graphQL<Q: GraphQLQuery>(_ query: Q, completion: @escaping (Result<Q.Output, Error>) -> Void)
        -> URLSessionDataTask
    {
        var request = URLRequest(url: baseURL.appendingPathComponent("graphql"))
        request.addValue("bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["query": query.query])

        let task = session.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(GraphQLError.missingData))
                return
            }

            do {
                let output = try query.transform(data)
                completion(.success(output))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
        return task
    }
}
