# treeg
`treeg` searches dirtrees for `git` repositories and prints a short status summary for each. It takes search paths from its config file `~/.treeg.conf` or from overriding shell arguments.

I needed a tool to provide a quick status overview for a dev tree. And sometimes it is useful to check specific ```git``` repositories - both these from afar.

```bash
$ treeg
$ treeg ~/projects/foo ~/.config/nvim
```

Put `treeg` in your `PATH` (e.g. `~/bin`) and place `.treeg.conf` in `HOME`.

`treeg` requires `ruby`, `git` and `fdfind` (`fd` on darwin).

Core parsing from [Jasper N. Brouwer](https://github.com/jaspernbrouwer)'s [powerline-gitstatus](https://github.com/jaspernbrouwer/powerline-gitstatus).

/tri:dʒiː/

:wq
