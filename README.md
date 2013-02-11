# Ignorance

Ensures specified files are ignored by Git, Mercurial or SVN.

## Use Case

You've created a utility to be used by others' projects which generates
or uses files and directories which ought not be committed/pushed/shared
with the world.

Ignorance helps your code be considerate of its users by protecting
their sensitive information.

## Installation

Add this line to your application's Gemfile:

    gem 'ignorance'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ignorance

## Usage

If you'd like to warn users and fellow developers to add certain artifacts
to the project's ignore file, you can include this somewhere in your runtime:

```ruby
include Ignorance

advise_ignorance '.myfile'
```

Assuming those files are not already in the project's ignore file, when
the code is run, your program will output the following to STDERR
(but not halt):

```
WARNING: please add ".myfile" to this project's .gitignore file!
```

If ignoring those files is really critical, you can halt with an exception:

```ruby
guard_ignorance 'mydir/'
```

You can even prompt the user, offering to automatically add the pertinent
files to the ignore file:

```ruby
negotiate_ignorance 'some_file.md'
```

And finally, if ignorance is absolutely critical, you can silently add
tokens to the project's ignore file:

```ruby
guarantee_ignorance! 'mydir/'
```

You can also use Ignorance directly (without including the module).
Shorter method names are provided for that purpose:

```ruby
Ignorance.advise '.myfile'
Ignorance.guard 'some_other_file.txt'
Ignorance.negotiate 'family_phone_numbers.yaml'
Ignorance.guarantee! 'bank_login.cfg'
```

## When Ignorance Works

Ignorance works on the ignore files of any and all detected repository types.
If .git is present, .gitignore is managed.  If .hg then .hgignore,
if .svn, .svnignore.  For Git and Mercurial, parent directories will also
be searched for a repository root.

Ignorance does nothing when one of two conditions exist:

1. All specified tokens are already ignored
2. The current directory is not within a repository

Ignorance's repo detection is based on the current working directory (e.g.
Dir.getwd, usually the directory where the code was launched).  It presumes
the common dev-time situation wherein a program is launched from within its
project dir.

This means that if your code uses Ignorance, and others use your code, repo
and ignore file detection will happen relative to their project directory.

## Adding a Comment

The #negotiate and #guarantee! methods (and their longer counterparts)
accept an optional comment parameter:

```ruby
negotiate_ignorance 'api_token.yml', 'added by HandyBankUtil'
```

This will add the following to the ignore file (assuming 'api_token.yml'
wasn't already ignored):

```
# added by HandyBankUtil
api_token.yml

```

If the supplied comment was already in the ignore file (suppose you
negotiated several tokens with the same comment), the new token will be
added to the bottom of that section.  So if the ignore file already had
this:

```
# added by HandyBankUtil
secret_info.txt

```

The above example would result in this:

```
# added by HandyBankUtil
secret_info.txt
api_token.yml

```

## Supported Operating Systems

Ignorance has been found to work on OSX, Ubuntu and Windows 7.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Do you love Ignorance, and want to make it even better?

Here's some stuff I ain't figured out yet:

- **Support for globs & regexes:** If you `advise_ignorance 'myfile.private'` and
  the ignore file contains a glob or regex which would cause that to be ignored,
  Ignorance will warn anyway.
- **Support for other version control systems.**  Visual SourceSafe can't use
  Ignorance.  Does that seem right to you?
