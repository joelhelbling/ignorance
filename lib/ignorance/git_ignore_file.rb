require 'ignorance/ignore_file'
require 'ignorance/project_oriented_vcs'

module Ignorance
  class GitIgnoreFile < IgnoreFile
    attr_reader :ignore_file, :repo_dir

    include ProjectOrientedVCS

    def initialize
      @ignore_file = '.gitignore'
      @repo_dir    = '.git'
    end

    private

    def ignored
      (file_contents + user_ignore_file_contents).reject do |t|
        t.match(/^\#/)
      end.map(&:chomp)
    end

    def user_ignore_file_contents
      File.exists?(user_ignore_file) ? File.readlines(user_ignore_file) : []
    end

    def user_ignore_file
      @user_ignore_file ||= `git config --global --get core.excludesfile`.chomp
    end

  end
end

