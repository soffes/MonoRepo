import Foundation

public final class ListQuery: GraphQLQuery {

    // MARK: - Types

    private struct OuterResponse: Codable {
        var data: Response
    }

    private struct Response: Codable {
        var viewer: Viewer
    }

    private struct Viewer: Codable {
        var organizations: Organizations
        var repositories: Nodes

        var repos: [Repository] {
            repositories.nodes + organizations.nodes
        }
    }

    private struct Organizations: Codable {
        var edges: [Edge]

        var nodes: [Repository] {
            edges.flatMap { $0.node.repositories.nodes }
        }

        struct Edge: Codable {
            var node: Node

            struct Node: Codable {
                var repositories: Nodes
            }
        }
    }

    private struct Nodes: Codable {
        var nodes: [Repository]
    }

    // MARK: - Initializers

    public init() {}

    // MARK: - GraphQLQuery

    public var query = """
{
  viewer {
    organizations(first: 100) {
      edges {
        node {
          repositories(first: 100, orderBy: { field: UPDATED_AT, direction: DESC }) {
            nodes {
              name
              nameWithOwner
              description
              url
            }
          }
        }
      }
    }

    repositories(first: 100, orderBy: { field: UPDATED_AT, direction: DESC }) {
      nodes {
        name
        nameWithOwner
        description
        url
      }
    }
  }
}
"""

    public func transform(_ data: Data) throws -> [Repository] {
        return try JSONDecoder().decode(OuterResponse.self, from: data).data.viewer.repos
    }
}
