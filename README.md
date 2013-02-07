# Ignant

Ensures specified files are ignored by Git or SVN

## Installation

Add this line to your application's Gemfile:

    gem 'ignant'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ignant

## Usage

If your code generates or uses files and directories which should not
be committed to version control, you can include this somewhere in
your runtime to warn users to add those artifacts to the project's
ignore file:

```ruby
include Ignant

guard_ignorance %w[ .myfile mydir/ ]
```

Assuming those files are not in the project's .gitignore file, when
the code is run, your program will output this (but not halt):

```
WARNING: You really should add the following to your .gitignore file:

.myfile
mydir/
```

If ignoring those files is really critical, you can halt with an exception
by using the bang version:

```ruby
guard_ignorance! %w[ .myfile mydir/ ]
```

And finally, you can even prompt the user, offering to automatically
add the pertinent files to the ignore file:

```
interactive_ignorance! %w[ .myfile mydir/ ]
```

Ignant does nothing when one of two conditions exist:

1. All specified files and directories are already ignored
2. The current directory is not a Git repository

SVN is also supported.  If .git is present, .gitignore is managed.  If
.svn is present, then .svnignore is managed.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
