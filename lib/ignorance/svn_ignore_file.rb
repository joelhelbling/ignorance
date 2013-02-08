require 'ignorance/ignore_file'

module Ignorance
  class SvnIgnoreFile < IgnoreFile
    attr_reader :ignore_file, :repo_dir

    def initialize
      @ignore_file = '.svnignore'
      @repo_dir    = '.svn'
    end

  end
end
