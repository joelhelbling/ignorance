require 'spec_helper'
require 'ignorance/hg_ignore_file'

module Ignorance
  describe HgIgnoreFile, :fakefs do

    let(:ignore_file) { '.hgignore' }
    let(:repo_dir)    { '.hg'       }

    it_should_behave_like "an ignore file"

  end
end
