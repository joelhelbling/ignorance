require 'ignorance/ignore_file'

module Ignorance
  class GitIgnoreFile < IgnoreFile
    attr_reader :ignore_file, :repo_dir

    def initialize
      @ignore_file = '.gitignore'
      @repo_dir    = '.git'
    end

    private

    def ignored
      (file_contents + user_ignore_file_contents).reject{ |t| t.match /^\#/ }.map(&:chomp)
    end

    def user_ignore_file_contents
      File.exists?(user_ignore_file) ? File.readlines(user_ignore_file) : []
    end

    def user_ignore_file
      @user_ignore_file ||= `git config --global --get core.excludesfile`.chomp
    end

  end
end

