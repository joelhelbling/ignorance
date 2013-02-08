require 'ignorance/ignore_file'

module Ignorance
  class GitIgnoreFile < IgnoreFile
    attr_reader :ignore_file, :repo_dir

    def initialize
      @ignore_file = '.gitignore'
      @repo_dir    = '.git'
    end

  end
end

