require 'spec_helper'
require 'ignorance'

describe Ignorance do

  describe "class methods (e.g. Ingorance.guard...)" do
    subject { Ignorance }
    it { should respond_to :advise, :guard, :negotiate, :guarantee! }
  end

  describe "when included" do
    before do
      class TestIncluder
        include Ignorance
      end
    end
    subject { TestIncluder.new }

    it do
      should respond_to :advise_ignorance,
                        :guard_ignorance,
                        :negotiate_ignorance,
                        :guarantee_ignorance!
    end
  end

  context "with Git" do
    let(:ignore_file) { '.gitignore' }
    let(:repo_dir)    { '.git'       }

    it_should_behave_like Ignorance
  end

  context "with Mercurial" do
    let(:ignore_file) { '.hgignore' }
    let(:repo_dir)    { '.hg'       }

    it_should_behave_like Ignorance

  end

  context "with SVN" do
    let(:ignore_file) { '.svnignore' }
    let(:repo_dir)    { '.svn'       }

    it_should_behave_like Ignorance

  end
end
