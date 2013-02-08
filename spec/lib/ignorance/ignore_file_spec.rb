require 'spec_helper'
require 'ignorance/ignore_file'
require 'ignorance/git_ignore_file'

module Ignorance
  describe IgnoreFile do

    it { should respond_to :exists?, :its_a_repo?, :ignored?, :ignore! }

  end
end
