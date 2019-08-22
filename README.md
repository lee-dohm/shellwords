# Shellwords

Functions for manipulating strings according to the word parsing rules of the UNIX Bourne shell.

The intention is to duplicate the functionality of the [Ruby Shellwords library][shellwords].

[shellwords]: http://ruby-doc.org/stdlib/libdoc/shellwords/rdoc/index.html

## Archived

This effort was shelved and repository was archived because I found out that the [Elixir OptionParser.split/1 function](https://hexdocs.pm/elixir/OptionParser.html#split/1) did what I wanted.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `shellwords` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:shellwords, "~> 0.1.0"}
  ]
end
```

## License

[MIT](LICENSE.md)
