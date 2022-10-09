# Rails React Chat Backend

An API for chat app.

## Using

- Ruby 2.7.1
- Rails 6.0.2.1
- MySQL 8.0
- Redis 7.0.5

## Develop

### Prerequisites

- Docker ^20.10.17

### Installation

- Clone repo

```bash
$ git clone git@github.com:jackradian/rails-react-chat-backend.git
$ cd rails-react-chat-backend
```

- Build image

```bash
$ docker compose build
```

- Bundle install

```bash
$ docker compose run --rm runner bundle install
```

- Init database and create seed data

```bash
$ docker compose run --rm runner bundle exec rails db:setup
```

- Enable cache (session is stored in cache)

```bash
$ docker compose run --rm runner bundle exec rails dev:cache
```

### Run server

```bash
$ docker compose up api
```

API will be hosted at `localhost:3000`.

### Stop server

Press <kbd>Ctrl</kbd> + <kbd>C</kbd>

## Test

- Run test case

```bash
$ docker compose run --rm runner bundle exec rspec
```
