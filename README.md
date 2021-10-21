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

Makefile is used as a wrapper around docker-compose commands.
Some commands are aliases around mix aliases, just to avoid boring and repetitive typing. 

#### make commands

```bash
build                          Build all services containers
delete                         Delete all containers, images and volumes
halt                           Shoutdown all services containers
init                           Setup application components
setup                          Setup application database
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

## API Documentation

API design and documentation are available at `http://localhost:4000/doc/swagger`, this contains a live suite to try real endpoints. 
Please consider this endpoint should be moved to a private or protected endpoint in production.


## Monitoring

Basic monitoring is available through *Phoenix LiveDashboard* available at `http://localhost:4000/private/dashboard/home`.
Please consider this endpoint should be moved to a private or protected endpoint in production.


## Improvements / Missing parts

- add structured logs
- add telemetry stuff
- add opentelemetry stuff
- add monitoring and business metrics
- introduce chaos monkey / mutation testing
- increase code coverage
- move `/private` and `/doc` to private or protected endpoints
- add release optimizations and configurations
