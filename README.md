# README

* ### Ruby version:
  2.6.3

* ### System dependencies
  run `bundle install` to install gems

* ### Configuration:
  add Github access key in .env file `GITHUB_ACCESS_KEY` environment variable.

* ### Database creation & migration:
  rake db:create db:migrate

* ### How to run the test suite
  `rpsec .`

* ### Main component of the project
  1. `app/controllers/router_controller.rb` control routing of accessing technology, category and repository
  2. `app/controllers/repositories_controller.rb` having the action for creating repository
  3. `app/services/graphql` helps to initial service to access Github graphql API and define graphql queries
  4. `app/errors` hold all customized error entity
  5. `app/form/repository_form_builder.rb` helps to create repository as a form object
  6. `app/models/repository` helps to parse jsonb
  7. `vcr` holds api request and response for playback
  8. `spec` holds all the test written in rspec
