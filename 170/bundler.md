# Bundler & Ruby Project Tooling

  * Small Ruby programs might consist of one or two files and only use built-in libraries (fromthe Ruby Std-lib) such as `date` or `YAML`.
  * Larger programs are likely to use *external* libraries - known as *Gems* (or *RubyGems*)
  * When using external dependencies such as Gems, your program needs a way of managing those dependencies

### Bundler

  * [Bundler](http://bundler.io/) is a program used to manage dependencies of Ruby projects
  * Bundler ensures that all of RubyGems required by a project are installed on the machines where that project is used - moreover it ensures that the same *versions* of each Gem is used across the different machines
  * Prior to BUndler, devs and devops would have to install and manage Gems for a project manually, which could lead to inconsistencies in environments and, ultimately, bugs
  * Bundler provides a **reproducible environment** within which an application can run
  * Bundler makes development and deployment much simpler - with Bundler, a single command can install all of a projects dependencies

#### Gemfile

  * `Gemfile` is one of the primary files used by Bundler.
  * `Gemfile` lists all of the RubyGems that a project uses

Example:

```ruby
source "https://rubygems.org"

gem "sequel"
gem "pg"
```

  * Calls to the `gem` method can also be made in a block

Example:

```ruby
source "https://rubygems.org" do
  gem "sequel"
  gem "pg"
end
```

  * This `Gemfile` is for a Ruby project that connects to a PostgreSQL database.
  * Although `Gemfile` does not have an `.rb` extension, it contains Ruby code
    * `source` and `gem` are actually Ruby method calls
    * `source` defines where Bundler should look for the libraries declared in the rest of the file
      * Generally the source will always be `https://rubygems.org` unless you are using a private Gem server
      * Gemfiles require at least one gem source in the form of a URL for a RubyGems server
      * Sources can be defined on a per Gem basis by passing an additional argument to the `gem` method which over-rides the previously declared `source`
      * Git repositories are also valid gem sources, as long as the repo contains one or more valid gems
    * Calls to `gem` declare the RubyGems that the project uses
    * The names are the same as the names you might use to install the library using `gem install`
    * The `gem` method can have additional arguments passed to it, such as version, alternative sources and `:require` flags

    * Read more about `Gemfile` at [http://bundler.io/gemfile.html](http://bundler.io/gemfile.html)

#### Gemfile.lock

  * `Gemfile.lock` is the other main file that Bundler uses, along with `Gemfile`, to manage dependencies
  * Whereas `Gemfile` is where a developer requests a specific set of dependencies, `Gemfile.lock` describes exactly which Gems and what versions of those Gems were installed when `bundle install` was run
  * `Gemfile.lock` is crucial for ensuring that the exact same versions of dependencies are used every time a project is run

Example:

```bash
GEM
  remote: https://rubygems.org/
  specs:
    pg (0.18.4)
    sequel (4.36.0)

PLATFORMS
  ruby

DEPENDENCIES
  pg
  sequel

BUNDLED WITH
   1.12.5
```

  * `Gemfile.lock` shows the specific versions of the requested Gems that were installed
  * If `Gemfile` requests a Gem that requires another RubyGem, those dependencies are also shown in `Gemfile.lock`

  * `Gemfile` is where a developer requests which libraries a project needs
  * `Gemfile.lock` is where Bundler lists *exactly* what it ended up installing when `bundle install` was run

  * Unless there is a specific reason not to, `Gemfile` and `Gemfile.lock` should be checked into the repository along with the code of a project

#### Installing Bundler

  * Bundler is installed like any other gem, using the `gem` command

Example:
```bash
$ gem install bundler
Successfully installed bundler-1.12.5
1 gem installed
```

#### Installing a Project's Dependencies

  * This is done by running `bundle install` in the same directory as the `Gemfile`

Example:
```bash
$ bundle install
Fetching gem metadata from https://rubygems.org/
Fetching version metadata from https://rubygems.org/
Resolving dependencies...
Using pg 0.18.4
Installing sequel 4.36.0
Using bundler 1.12.5
Bundle complete! 2 Gemfile dependencies, 3 gems now installed.
Use `bundle show [gemname]` to see where a bundled gem is installed.
```

#### Adding Dependencies a Project

  * To add a new RubyGem to a project, just add a line to the project's `Gemfile`
  * **Always** run `bundle install` after making changes to `Gemfile`

#### Running Executables

  * If you install a Gem that includes an executable, when you run it you should prepend the command with `bundle exec`

Example:
```bash
$ bundle exec sequel
Your database is stored in DB...
```
The Sequel library includes an executable program called `sequel` that allows a user to connect to a database in a REPL. to run that executable within the project we would use `bundle exec sequel`

  * Using `bundle exec` also ensures that we are using the correct RubyGems and versions of those gems.
  * If `bundle exec` was not used, we could easily end up using other versions of the Gems installed on our system

#### Creating an Empty Gemfile

  * Running `bundle init` will create an empty `Gemfile`
  * A `--gemspec` option can be passed to `bundle init` which will automatically add each dependency listed in the specified gemspec file to the newly created Gemfile

Example:
```bash
$ bundle init --gemspec="/PATH/TO/DEFAULT/GEMSPEC_FILE"
```

  * `Gemfile` could also be created in other ways. It's just a text file with a special name

#### Loading Dependencies

  * To set up the Ruby environment using Bundler, the following lines need to be included in your main application file:

```ruby
require 'rubygems'
require 'bundler/setup'
```

  * After that you can require RubyGems normally in your code files - Bundler will make sure that the correct version is loaded

#### Specifying a Ruby Version

  * If you need to ensure that your project runs on a specific version of Ruby, this can be enforced by calling `ruby` within a `Gemfile`

Example:
```ruby
source "https://rubygems.org"

ruby "2.3.1"

gem "sequel"
gem "pg"
```

  * This will ensure the specified Ruby version is used to run the project. If a different version is used an error message will be received.

Example:
```bash
$ bundle install
Your Ruby version is 2.3.1, but your Gemfile specified 2.3.0
```

#### Groups

  * `group` can be used to organise Gems within a `Gemfile`
  * This is commonly done to avoid installing some dependencies - e.g. some libraries may only be used for testing and are not required in production
  * `group` can be used with a block containing the Gems for that group

Example:
```ruby
source "https://rubygems.org"

ruby "2.3.1"

gem "sequel"
gem "pg"

group :development do
  gem "pry"
end

group :test do
  gem "minitest"
end
```

  * Groups can also be specified as an argument to `gem`

Example:
```ruby
gem 'pg'
gem 'sequel'

gem 'pry', :group => :development
gem 'minitest', :goup => :test
```

  * By default, `bundle install` will install all gems from all groups
  * To avoid installing Gems from a partcular `group` the `--without` option can be passed to `bundle install`
  * Many Ruby projects will have groups for `development`, `test`, and `production`

#### More about Bundler

  * Bundler has many other features
  * To learn more check out the documentation on the official site: [http://bundler.io](http://bundler.io)
