# Cleo

A telegram bot. Cleo receives messages and sends them to a queue for processing. After processing, the message is categorized with an action, and this action is answered to the user.

## Prerequisites

You will need the following things properly installed on your computer:

* [Elixir 1.6](https://github.com/elixir-lang/elixir)
* [RabbitMQ](https://hub.docker.com/_/rabbitmq/)

## Installation

Execute the following commands to install dependencies:

```bash
$ cd cleo
$ mix deps.get
```

## Usage

Init project:

```bash
$ iex -S mix
```

## Contributing

1. Clone it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D
