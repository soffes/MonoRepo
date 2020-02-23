# MonoRepo

Swift command line tool for treating GitHub like a monorepo. WIP.

## Design

### Background

I have a command line utility called [`c`](https://github.com/soffes/dotfiles/blob/master/.zsh/functions/c) (inspired by [Ryan Bates](https://github.com/ryanb/dotfiles)). I use to navigate my `~/Code` folder. I keep it structured like this:

    org_name/
        repo_name/
        repo_name/
    org_name/
        repo_name/
        repo_name/
    ...

So if my dotfile are [github.com/soffes/dotfiles](https://github.com/soffes/dotfiles), I can type `c soffes/dotfiles` to navigate there.

There is also autocompletion for this utility, so normally, I’d type something like `c s⇥dot⇥↩︎` using tab to only type a few characters.

### Goal

The goal of this project is to wrap this functionality in a utility. Currently, I’ve been using `mr` (for monorepo) as the name.

#### Examples

Frequently, I try to `c` to a repo that I haven’t cloned. This is common when GitHub sends a security alert for a very old repo I haven’t had on my computer in years.

    $ c soffes/screensavers.cool
    > no such file or directory
    $ c soffes
    $ git clone https://github.com/soffes/screensavers.cool
    $ c soffes/screensavers.cool

Ideally this could be shortened to the following with autocompletion still working:

    $ mr soffes/screensavers.cool

I also do this a lot:

    $ c soffes
    $ mkdir new_project
    $ cd new_project
    *go to github.com/new and create it*
    $ git init
    $ git remote add origin https://github.com/soffes/new_project

It would be great if this could also be shorted to:

    $ mr soffes/new_project
    > new_project doesn’t exist, do you want to create it? [Yn]

or maybe:

    $ mr new soffes/project

#### Other Ideas

Fork and clone a repo to your local disk:

    $ mr fork apple/swift soffes/swift

Backup everything to an external disk (likely needs more configuration):

    $ mr backup --destination=/Volumes/Backup/Code
