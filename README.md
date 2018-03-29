# UmbrellaConflict

To reproduce error, run:

```
$ mix deps.get # works fine locally on macOS

$ docker build -t umbrella_conflict:latest . # crashes
```

If you then update `apps/app_2/mix.exs` with:

```elixir
defp deps do
    [
      {:swoosh, "~> 0.13"}
    ]
end
```

Both commands will work fine.
