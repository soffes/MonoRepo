func main() {
    var arguments = CommandLine.arguments
    arguments.remove(at: 0)

    guard let first = arguments.first else {
        help()
    }

    if first == "--autocomplete" {
        autocomplete()
    }

    help()
}

main()
