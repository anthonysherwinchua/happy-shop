# Hapy Shop

Happy Shop is an e-commerce retailer specializing in beauty products. They have an existing
web platform and are planning to release native mobile applications. For that to happen, you are
tasked to build endpoints for the mobile applications to which will consume these endpoint

## System Dependencies

The following are needed by this project:

* [PostgreSQL](http://www.postgresql.org/) at least version 9.4

## Getting Started

Clone this repository and bundle.

```bash
git clone git@github.com:anthonysherwinchua/happy-shop.git
cd happy-shop
bundle install
```

Create a `database.yml` file from the sample and modify if necessary.
The defaults should be fine.

```bash
cp config/database.yml.sample config/database.yml
```

Create a `.env` file from the sample so [dotenv](https://github.com/bkeepers/dotenv) can set the required environment variables.
Please obtain any missing values from the project administrator.

```bash
cp .env.sample .env
```

Create and initialize the database.

```bash
rake db:create db:migrate db:seed
```

Start the application server.

```bash
rails server
```

## Access the Product listing

    curl -i -H "Content-Type: version=1" http://localhost:3000/products

## Testing

Run the test suite with [RSpec](https://github.com/rspec/rspec-rails).

    rspec spec/

## Coding Style

```bash
# Run rubocop
bundle exec rubocop
`

## Branch Policy

Local development branch naming:

* `feature/<branch_name>` for substantial new feature or function
* `enhance/<branch_name>` for minor feature or function enhancement
* `bugfix/<branch_name>` for bug fixes

* `development` for staging; branch out from this to create and/or enhance existing feature(s);
* `master` for production only

## Deployment

The application is deployed to [Heroku](https://www.heroku.com/) at:

* [Production](https://happy-shop-by-sherwin.herokuapp.com/)
* [Staging](https://happy-shop-by-sherwin-staging.herokuapp.com/)


### Raising a bug, issue, or suggestions?

Create an issue at [Happy Shop Github Issue](https://github.com/anthonysherwinchua/happy-shop/issues)
