# README

SEvS - produces report comparing Side Effects vs Symptoms

* Ruby version

2.6.3 or so

* Database creation / initialization

The database seeds from the SIDER database online at
[http://sideeffects.embl.de/](http://sideeffects.embl.de/).
You can, optionally, change the source location to a spot on the local
filesystem if you've already downloaded the database.  You can also show
the output with the appropriate parameters when seeding.  See db/seeds.rb
for details.

* How to run the test suite

TBD

* Deployment instructions

bundle install

RAILS_ENV=production rails db:setup

./run
