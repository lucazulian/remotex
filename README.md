# remotex

Elixir fun application that returns users with more than a random number of points

[![CI](https://github.com/lucazulian/remotex/actions/workflows/elixir-ci.yml/badge.svg)](https://github.com/lucazulian/remotex/actions/workflows/elixir-ci.yml)


## Requirements
  
  - docker **20+**
  - docker-compose **1.29+**
  - GNU make **4+**


## Development links

  * [Conventional Commits][1]
  * [Elixir Style Guide][2]

  [1]: https://www.conventionalcommits.org/en/v1.0.0/
  [2]: https://github.com/christopheradams/elixir_style_guide


## Getting started

#### make commands

```bash
build                          Build all services containers
delete                         Delete all containers, images and volumes
halt                           Shoutdown all services containers
init                           Setup application components
shell                          Enter into remotex service
start                          Start application
up                             Start all services
```


## How to use

### Docker

#### Setup the project

```bash
make init
```

TODO


## Improvements / Missing parts / Bugs

- add structured logs
- add opentelemetry stuff
- introduce chaos monkey / mutation testing
