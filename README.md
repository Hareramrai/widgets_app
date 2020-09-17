# README

This README would normally document whatever steps are necessary to get the
application up and running.

Application deployed at https://showoff29.herokuapp.com/ .

Things you may want to cover:

- Ruby version (2.7.1)

- System dependencies

  1. `Ruby 2.7.1`
  2. `Rails 6.0.3`
  3. `Postgres`
  4. `Docker for Mac`
  5. `YARN`

- Database creation

  `docker-compose run web rake db:create db:migrate`

- Build & Start the Application

1.  `docker-compose build`
2.  `docker-compose up`

- How to run the test suite

`SIMPLECOV=true bundle exec rake spec`

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions
