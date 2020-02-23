import Foundation

func accessToken() -> String {
    guard let accessToken = ProcessInfo.processInfo.environment["GITHUB_ACCESS_TOKEN"] else {
        print("Please define GITHUB_ACCESS_TOKEN.")
        exit(EXIT_FAILURE)
    }

    return accessToken
}
