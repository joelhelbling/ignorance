require 'stringio'

module IOHelpers

  def stdout_from
    out = StringIO.new
    $stdout = out
    yield
    return out.string.chomp
  ensure
    $stdout = STDOUT
  end

  def stderr_from
    err = StringIO.new
    $stderr = err
    yield
    return err.string.chomp
  ensure
    $stderr = STDERR
  end

end
