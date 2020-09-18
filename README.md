# Widgets Application

## About

This is a Ruby on Rails application, which consumes the rest-client provided by `https://showoff-rails-react-production.herokuapp.com/`. 
The API call is handled by `rest-client` gem. 

We have used above rest API to provide features like authentication, user management, widgets management with filters.

Also, our application embraces the refresh token approach so that we would be able to call our API till EOL. 

Application deployed at https://showoff29.herokuapp.com/ .


## System dependencies

  1. `Ruby 2.7.1`
  2. `Rails 6.0.3`
  3. `Postgres`
  4. `Docker for Mac`
  5. `NODEJS`
  6. `YARN`

## Development Setup

- Build Docker 
 
  `docker-compose build`
 
- Database creation

  `docker-compose run web rake db:create db:migrate`

- Start the Application
   
   `docker-compose up`

## How to run the test suite

`SIMPLECOV=true bundle exec rake spec`
 
 I have added a sample test case, this could be implemented throughout the application, but would require extra time. 
 May be added as things to improve.
 
## Patterns of Development

I personally try to keep things simple and small as much as possible. I am a fan of DRY but don't like to go super dry. 

Now, I would like share my thought on some extra directory in this application. 

Btw I am a good believer of the single responsibility principle & prefer to have a number of classes instead of having a giant single class. 

### Forms

I have used the `forms` directory to separate these special ruby classes from the models. 
I have used this for two reasons.

1. To have clear visibility. 
2. Don't want to call external api's from the rails model directory. 

I have used a name `Registration` for sign up and update profile but I think we could have some alternate name like `WidgetUser`. 

### Services

Services are PORO and used to perform the operation which is not suitable for model and controller and must adhere the single responsibility principle. 

I prefer to expose only one endpoint from the service that would be invoked. 

#### app/services/widgets/*

Here I have created two clients which uses rest-client gem to call the external service. 

`Widgets::Client` is going to call API using `access_token`. 

`Widgets::OauthClient` is going to call the api using `client_id` & `client_sceret`. 

I have created these two because I didn't want to mix these two and complicate the implementation. 


## Deployment instructions

- `git push heroku master`

## Area of improvement

1. Adding some test cases.
2. Adding caching for the API call. 
3. May be using react for the UI.
4. Exploring some other gem like [HER](https://github.com/remi/her) or Faraday.
