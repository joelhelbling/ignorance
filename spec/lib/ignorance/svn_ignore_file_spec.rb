require 'spec_helper'
require 'ignorance/svn_ignore_file'

module Ignorance
  describe SvnIgnoreFile, :fakefs do

    let(:ignore_file) { '.svnignore' }
    let(:repo_dir)    { '.svn'       }

    it_should_behave_like "an ignore file"

  end
end

