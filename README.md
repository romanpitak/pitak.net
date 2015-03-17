# pitak.net

Static files for [pitak.net](http://pitak.net)

## Usage

Build the `public` directory:

    make

For development, run:

    make dev

That will serve the public directory on `localhost:31415`,
watch for changes in the source code and rebuild `public` when necessay.

Watch and rebuild `public` without running the server:

    make watch

## About this site

Written in&nbsp;the&nbsp;[jade template engine](http://jade-lang.com)
with&nbsp;[Sass](http://sass-lang.com/)
and&nbsp;[literate CoffeScript](http://coffeescript.org/#literate).
The&nbsp;design is based on&nbsp;the&nbsp;[Lanyon](http://lanyon.getpoole.com/)
theme for&nbsp;[Jekyll](http://jekyllrb.com/)
, but rewritten from scratch in Sass.  The page and blog builder runs
in&nbsp;[Node.js](http://nodejs.org/)
and&nbsp;the&nbsp;whole site is put together
by&nbsp;the&nbsp;[GNU Make](http://www.gnu.org/software/make/).

The whole site is&nbsp;more or&nbsp;less an&nbsp;excercise
in&nbsp;front&nbsp;end development since I&nbsp;am mainly
a&nbsp;back&nbsp;end guy.
