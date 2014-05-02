# Rvmpow

`rvmpow` is usefull only if:

- you are a rails developper
- you use rvm
- you use pow

[Pow](http://pow.cx) needs to know what ruby and gemset is being used.

You can add this information [manually](http://rvm.io/integration/pow) or use rvmpow`.

## Installation

```
$ gem install rvmpow
```

## Usage

Make sure you are in the root directory of your rails app before running:

```
$ rvmpow init
```

To open the app in your default browser directly after initialization, run:


```
$ rvmpow init --show
```

To open the app after initialization, run:

```
$ rvmpow open
```

rvmpow comes with extensive help built in, just run:

```
$ rvmpow
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/rvmpow/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
