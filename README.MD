# Installation Instructions

## Requirements

* Ruby v2.2.6
* Rails v4.2.4
* PostgreSQL

## Installation Steps

* Clone this repository to your desktop environment.
* cd /project_directory

### Install Project Dependencies with:
```
bundle install / bundle update
```
### Setup the database tables.
```
rake db:migrate / rake db:reset
```
### Run the Application
```
rails s
```
