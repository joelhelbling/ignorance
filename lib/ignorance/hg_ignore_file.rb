require 'ignorance/ignore_file'
require 'ignorance/project_oriented_vcs'

module Ignorance
  class HgIgnoreFile < IgnoreFile
    attr_reader :ignore_file, :repo_dir

    include ProjectOrientedVCS

    def initialize
      @ignore_file = '.hgignore'
      @repo_dir    = '.hg'
    end

  end
end
