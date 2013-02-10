require 'spec_helper'
require 'ignorance/git_ignore_file'

module Ignorance
  describe GitIgnoreFile, :fakefs do

    let(:ignore_file) { '.gitignore' }
    let(:repo_dir)    { '.git'       }

    it_should_behave_like "an ignore file"

    context "when the user's gitignore file includes the token" do
      let(:token) { "foofile.md" }
      let(:user_ignore_file) { '~/.gitignore' }
      before do
        ignorefile_write %w[other stuff here].join("\n")
        File.open(user_ignore_file, 'w') do |fh|
          fh.write "#{token}\n"
        end
        subject.stub(:user_ignore_file).and_return(user_ignore_file)
      end

      specify "then the file is ignored" do
        File.read('~/.gitignore').should match /#{token}/
        subject.ignored?(token).should be_true
      end
    end
  end
end
