require 'ignorance/ignore_file'

module Ignorance
  class HgIgnoreFile < IgnoreFile
    attr_reader :ignore_file, :repo_dir

    def initialize
      @ignore_file = '.hgignore'
      @repo_dir    = '.hg'
    end

  end
end
