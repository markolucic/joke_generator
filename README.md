## Requirements

This application uses:

* Ruby 2.5.1
* Rails 5.2.1
* Mysql 0.5.2

## Getting Started

Clone the the repository

```console
$ git clone https://github.com/markolucic/joke_generator.git
```

Install dependencies:

```console
$ bundle install
```

Set up the database:

```console
$ rails db:setup
```

Run the application:

```console
$ rails s
```

## Testing

To run the tests:

```console
$ rspec
```

## Usage
 
In order to generate new jokes 

```
GET http://localhost:3000/api/v1/jokes

param: joke_count - number of jokes to generate (optional)
```
