# Kisaveikkaus web app for London 2012 olympic games

    App written in 2012, dug source code from archives on April 2016 :)

A friend of mine used to organize betting competitions to go with Olympic games. The main idea was to guess three medalists within every competition, and the one who gets most right, in exact order, wins.

Tried 30mins to spin this app up, but too much have changed, and didn't even write proper documentation back then, so couldn't get a screenshot of the app. Basic Bootstrap layout, everyone knows how it looks... :D

It's four years since I made this, and can't even remember all the tidbits what went along, but Ruby On Rails still looks awesome, and would like to work with it again in the future :) Code does not look nice, cos it was my first bigger project with RoR, but it got us through the games, and I came second in our competition ;)

Brief explanation below:

### Models:  

    app/models/

Basic RoR models, nothing special.

### Controllers

    app/controllers

RESTful routes overall on controllers, supported with some basic methods.

### Views

View layer was made (almost) completely in Haml, which was hot topic back then...

### Misc.

Used Postgres for backend, but RoR pg adapter made all the heavy lifting of course.

## Tech Stack

* Ruby
* Rails
* Haml
* Bootstrap
* Unicord

Also made some Unicorn deployment scripts, but can't find them anymore ;)
