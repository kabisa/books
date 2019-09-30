# Books

## Introduction

...

## Demo

A [demo version](https://thawing-badlands-71406.herokuapp.com/) is available on Heroku. 
This version has been deployed as described [here](https://devcenter.heroku.com/articles/getting-started-with-rails5).

## Installation

- `git clone <repository-url>` this repository
- `cd books`
- `bundle install`
- `bin/rails db:setup`

## Running / Development

- `bin/rails s`
- Visit your app at [http://localhost:3000](http://localhost:3000).


## Technical details

### Daemonite's Material UI

Since I never used [Material Design](https://material.io/) before, I thought this project would make a good candidate. For this I used [Daemonite's Material UI](http://daemonite.github.io/material/), which uses Bootstrap with some customizations added to it. Instructions on how to use Daemonite's Material UI in a Rails project can be found [here](https://gist.github.com/bazzel/0226bf815c9018388ae2e7e3bc438c57).

### Class diagram

A diagram of the models is available [here](docs/erd.svg).  
To update the diagram, run the following command:

`bin/rails erd`


### SendGrid

The production version of this application uses [SendGrid](http://sendgrid.com) for sending mails.
