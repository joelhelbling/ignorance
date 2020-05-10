require 'spec_helper'
require 'ignorance/git_ignore_file'

module Ignorance
  describe GitIgnoreFile, :fakefs do

    let(:ignore_file) { '.gitignore' }
    let(:repo_dir)    { '.git'       }

    it_should_behave_like "an ignore file"
    it_should_behave_like "a project-oriented VCS"

    context "when the user's gitignore file includes the token" do
      let(:token) { "foofile.md" }
      let(:user_ignore_file) { '~/.gitignore' }
      before do
        ignorefile_write %w[other stuff here].join("\n")
        Dir.mkdir('~/')
        File.open(user_ignore_file, 'w') do |fh|
          fh.write "#{token}\n"
        end
      end

      specify "then the file is ignored" do
        expect(File.read('~/.gitignore')).to match(/#{token}/)
        expect(subject).to be_ignored(token)
      end
    end

  end
end
