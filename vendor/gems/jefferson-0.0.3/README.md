# Jefferson

Thomas Jefferson was a big education guy.  He built UVA for crying out loud. His picture is on the $2 y'all!

**Jefferson** is a REST API client gem that accesses the [Learning Registry API](https://github.com/LearningRegistry/LearningRegistry).

## Installation

Clone the repo from Github

  git clone git@github.com:sjtipton/jefferson.git

Install any dependencies

  bundle install

Build the gem

  bundle exec rake build

Install the gem

  ruby -S gem install ./pkg/jefferson-0.0.3.gem

To vendorize into a project

  cd path/to/project

  gem unpack jefferson -v 0.0.3 --target ./vendor/gems