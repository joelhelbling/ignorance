require 'spec_helper'
require 'ignorance/git_ignore_file'

module Ignorance
  describe GitIgnoreFile, :fakefs do

    let(:ignore_file) { '.gitignore' }
    let(:repo_dir)    { '.git'       }

    it_should_behave_like "an ignore file"

  end
end
