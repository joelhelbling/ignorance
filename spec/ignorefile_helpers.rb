module IgnorefileHelpers

  def ignorefile_write(contents)
    File.open(ignore_file, 'w') do |fh|
      fh.write contents
    end
  end

  def ignorefile_lines
    File.readlines(ignore_file)
  end

  def ignored_tokens
    ignorefile_lines.map(&:chomp)
  end

  def ignorefile_contents
    File.read(ignore_file)
  end

  def mk_repo_dir
    Dir.mkdir repo_dir
  end

end
