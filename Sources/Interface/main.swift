import Foundation
import MonoRepo

func main() {
    guard let accessToken = ProcessInfo.processInfo.environment["GITHUB_ACCESS_TOKEN"] else {
        print("Please define GITHUB_ACCESS_TOKEN.")
        exit(EXIT_FAILURE)
    }

    let client = Client(accessToken: accessToken)
    dispatchGroup.enter()
    client.listRepositories { result in
        switch result {
        case .success(let repos):
            repos.forEach { print($0.nameWithOwner) }
        case .failure(_):
            print("Failed")
            exit(EXIT_FAILURE)
        }

        dispatchGroup.leave()
    }
}

let dispatchGroup = DispatchGroup()
main()
dispatchGroup.notify(queue: DispatchQueue.main) {
    exit(EXIT_SUCCESS)
}

dispatchMain()
