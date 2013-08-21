# Development notes

Version bumping
---------------

Edit the following files:

 * lib/jquery-turbolinks/version.rb
 * package.json
 * src/jquery.turbolinks.coffee

Updating .js files
------------------

Update the .js files from the source CoffeeScript file using:

    $ rake js:bulid js:uglify

Testing
-------

Simply use npm/mocha:

    $ npm install
    $ npm test

Or:

    $ rake test

Releasing
---------

Release it into npm/rubygems using:

    $ rake release
