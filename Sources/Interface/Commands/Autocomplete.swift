import Foundation
import MonoRepo

func autocomplete() -> Never {
    let client = Client(accessToken: accessToken())
    let semaphore = DispatchSemaphore(value: 0)

    client.listRepositories { result in
        switch result {
        case .success(let repos):
            repos.forEach { print($0.nameWithOwner) }
        case .failure(_):
            print("Failed")
            exit(EXIT_FAILURE)
        }

        semaphore.signal()
    }

    semaphore.wait()
    exit(EXIT_SUCCESS)
}
