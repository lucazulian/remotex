# remotex

Elixir fun application that returns users with more than a random number of points

[![CI](https://github.com/lucazulian/remotex/actions/workflows/elixir-ci.yml/badge.svg)](https://github.com/lucazulian/remotex/actions/workflows/elixir-ci.yml)


## About the Application

TODO


## Requirements
  
  - postgres **14.0+**
  - Erlang/OTP **24**
  - elixir **1.12.3**
  
  or

  - docker **20+**
  - docker-compose **1.29+**
  - GNU make **4+**
  

## Development links

  * [Conventional Commits][1]
  * [Elixir Style Guide][2]

  [1]: https://www.conventionalcommits.org/en/v1.0.0/
  [2]: https://github.com/christopheradams/elixir_style_guide


## Getting started

### Local environment

In your local environment it needs to install all *Requirements* and requires you to have setup PostgreSQL beforehand.

#### Gets all dependencies

```bash
mix deps.get
```

#### Setup PostgreSQL instance, start migration and seeds scripts

```bash
mix setup
```

#### Start application

```bash
mix phx.server
```


### Docker Compose

Docker Compose is used to simplify development and components installation (like PostgreSQL) and configurations.
Makefile is used as a wrapper around docker-compose commands.
Some commands are aliases around mix aliases, just to avoid boring and repetitive commands. 

#### Make commands

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

#### Setup the project

```bash
make init
```

#### Start the project

```bash
make start
```

#### Destroy environment

```bash
make delete
```


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
