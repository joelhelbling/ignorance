require 'highline'
require 'ignorance/version'

require 'ignorance/git_ignore_file'
require 'ignorance/hg_ignore_file'
require 'ignorance/svn_ignore_file'

module Ignorance

  class << self
    def advise(token, comment=nil)
      active_ignore_files.each do |ignore_file|
        warning token, ignore_file unless ignore_file.ignored?(token)
      end
    end

    def warning(token, ignore_file)
      warn "WARNING: please add \"#{token}\" to this project's #{ignore_file.name} file!"
    end

    def guard(token, comment=nil)
      active_ignore_files.each do |ignore_file|
        unless ignore_file.ignored?(token)
          raise IgnorefileError.new "Please add \"#{token}\" to this project's #{ignore_file.name} file!"
        end
      end
    end

    def negotiate(token, comment=nil)
      active_ignore_files.each do |ignore_file|
        unless ignore_file.ignored?(token)
          msg = "would you like me to add #{token} to this project's #{ignore_file.name} file automatically?"
          if agree? msg
            guarantee! token, comment
            puts "Added \"#{token}\" to this project's #{ignore_file.name} file."
          else
            warning token, ignore_file
          end
        end
      end
    end

    def guarantee!(token, comment=nil)
      active_ignore_files.each do |ignore_file|
        unless ignore_file.ignored?(token)
          ignore_file.ignore! token, comment
        end
      end
    end

    def active_ignore_files
      ignore_files.select(&:its_a_repo?)
    end

    def ignore_files
      [GitIgnoreFile.new, HgIgnoreFile.new, SvnIgnoreFile.new]
    end

    def agree?(msg)
      HighLine.new.agree("#{msg}  [Y]es/[n]o?  ")
    end

  end

  def advise_ignorance

  end

  def guard_ignorance

  end

  def negotiate_ignorance

  end

  def guarantee_ignorance!

  end

  class IgnorefileError < IOError; end

end
