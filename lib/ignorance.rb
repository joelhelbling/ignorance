require 'ignorance/version'

require 'ignorance/git_ignore_file'
require 'ignorance/hg_ignore_file'
require 'ignorance/svn_ignore_file'

module Ignorance

  class << self
    def guard(token, comment=nil)
      active_ignore_files.each do |ignore_file|
        unless ignore_file.ignored?(token)
          warn "WARNING: please add \"#{token}\" to this project's .gitignore file!"
        end
      end
    end

    def guard!

    end

    def guard_interactive

    end

    def active_ignore_files
      ignore_files.select(&:its_a_repo?)
    end

    def ignore_files
      [GitIgnoreFile.new, HgIgnoreFile.new, SvnIgnoreFile.new]
    end

  end

  def guard_ignorance

  end

  def guard_ignorance!

  end

  def guard_ignorance_interactive

  end

end
