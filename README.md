# treeg
`treeg` searches dirtrees for `git` repositories and prints a short status summary for each. It takes search paths from its config file `~/.treeg.conf` or from overriding shell arguments.

I needed a tool to provide a quick status overview for a dev tree. And sometimes its useful to check specific ```git``` repositories. Both these from afar.

```bash
$ treeg
$ treeg ~/projects/foo ~/.config/nvim
```

Put `treeg` in your `PATH` (e.g. `~/bin`) and place `.treeg.conf` in `HOME`.

Example config (`~/.treeg.conf`):

```
# Search for git repositories in these paths
~/projects
~/.config

# Sort output by mtime
sortmodified yes
# One-line explanation for the status symbols
explanation yes
# Hide clean git repositories
hideclean no

# Colored output?
colored yes
# Use black red green brown blue magenta cyan gray
dirty cyan
detached gray
clean green
```

`treeg` requires `ruby` and `git`.

Core parsing from [Jasper N. Brouwer](https://github.com/jaspernbrouwer)'s [powerline-gitstatus](https://github.com/jaspernbrouwer/powerline-gitstatus).

/tri:dʒiː/

:wq
