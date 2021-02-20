# NxLab

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `nx_lab` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:nx_lab, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/nx_lab](https://hexdocs.pm/nx_lab).

# Testing Nx

## Prerequisite for EXLA

$ sudo apt install python3-pip
$ pip3 install numpy
$ cd /usr/bin
$ sudo ln -s python3 python

$ asdf plugin add bazel
$ asdf install bazel 3.1.0
$ asdf global bazel 3.1.0

## Create project

$ mix new nx_lab
$ cd nx_lab

Add both dependencies

      {:exla, "~> 0.1.0-dev", github: "elixir-nx/nx", sparse: "exla"},
      {:nx, "~> 0.1.0-dev", github: "elixir-nx/nx", branch: "main", sparse: "nx", override: true}

$ mix deps.get
$ mix compile

It takes a long time...

## Testing

$ iex -S mix
Erlang/OTP 23 [erts-11.1.7] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [hipe]

Compiling 1 file (.ex)
Interactive Elixir (1.11.3) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> NxLab.run

20:48:47.406 [info]  CPU Frequency: 3502700000 Hz
 
20:48:47.411 [info]  XLA service 0x7f0700039360 initialized for platform Host (this does not guarantee that XLA will be used). Devices:
 
20:48:47.411 [info]    StreamExecutor device (0): Host, Default Version

...

#Nx.Tensor<
  f32[batch: 3][output: 10]
  [
    [0.006689148955047131, 2.825991832651198e-4, 0.0060700587928295135, 0.20865707099437714, 1.1693627129716333e-5, 0.7664985656738281, 4.334320838097483e-4, 0.003993285354226828, 0.004449605010449886, 0.0029145486187189817],
    [0.9984750151634216, 9.60795460969166e-8, 3.1861025490798056e-5, 3.79157681891229e-5, 1.3283175803735503e-7, 0.0013872049748897552, 1.1364873898855876e-5, 1.9032429918297566e-5, 2.664328167156782e-5, 1.0768767424451653e-5],
    [1.546680723549798e-4, 1.9850269018206745e-4, 0.010962015017867088, 0.03578181192278862, 0.8790845274925232, 0.0018610837869346142, 0.0011465282877907157, 0.009439081884920597, 0.0017419930081814528, 0.059629861265420914]
  ]
>
