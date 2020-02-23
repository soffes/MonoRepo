final class MainCommand: Command {
    func run() -> Never {
        var arguments = CommandLine.arguments
        arguments.remove(at: 0)

        guard let first = arguments.first else {
            help()
        }

        if first == "--autocomplete" {
            AutocompleteCommand().run()
        }

        help()
    }

    private func help() -> Never {
        HelpCommand().run()
    }
}
