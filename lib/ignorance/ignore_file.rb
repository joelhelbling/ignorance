module Ignorance
  class IgnoreFile

    def name
      ignore_file
    end

    def exists?
      File.exists? ignore_file
    end

    def its_a_repo?
      Dir.exists? repo_dir
    end

    def ignored?(token)
      ignored.include? token
    end

    def included?(token)
      file_contents.include? token
    end

    def ignore!(token, comment=nil)
      return true if ignored?(token)
      if comment
        anchor = commentified comment
        if included? anchor
          insert_after anchor, token
        else
          append "\n"
          append anchor
          append token
        end
      else # There's no comment
        append token
      end

      write_ignore_file
    end

    private

    def ignored
      file_contents.reject{ |t| t.match /^\#/ }.map(&:chomp)
    end

    def file_contents
      @file_contents ||= exists? ? File.readlines(ignore_file) : []
    end

    def insert_at(index, token)
      file_contents.insert(index, token)
    end

    def append(token)
      insert_at(file_contents.size, token)
    end

    def insert_after(anchor, token)
      insert_index = file_contents.find_index(anchor) + 1
      insert_index += 1 until here_is_good?(insert_index)
      insert_at insert_index, token
    end

    def here_is_good?(insert_index)
      at_maximum?(insert_index) || blank_line_at?(insert_index)
    end

    def at_maximum?(insert_index)
      insert_index >= file_contents.size
    end

    def blank_line_at?(insert_index)
      file_contents[insert_index].match(/^[\s\n]*$/)
    end

    def commentified(comment)
      "# " + comment.gsub(/^\s*\#\s*/, '')
    end

    def printified(line)
      line.chomp + "\n"
    end

    def write_ignore_file
      File.open(ignore_file, 'w') do |fh|
        file_contents.each do |line|
          fh.write printified line
        end
      end
    end

  end
end

