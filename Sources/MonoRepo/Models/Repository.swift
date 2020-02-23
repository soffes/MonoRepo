import Foundation

public struct Repository: Codable {
    public var name: String
    public var nameWithOwner: String
    public var description: String?
    public var url: URL
}
