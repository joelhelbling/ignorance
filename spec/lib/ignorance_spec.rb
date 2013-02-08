require 'spec_helper'
require 'ignorance'

describe Ignorance do

  describe "class methods (e.g. Ingorance.guard...)" do
    subject { Ignorance }
    it { should respond_to :guard, :guard!, :guard_interactive }
  end

  describe "when included" do
    before do
      class TestIncluder
        include Ignorance
      end
    end
    subject { TestIncluder.new }

    it { should respond_to :guard_ignorance, :guard_ignorance!, :guard_ignorance_interactive }
  end
  context "Git", :fakefs do
    before { mk_repo_dir }
    let(:ignore_file) { '.gitignore' }
    let(:repo_dir)    { '.git'       }
    let(:token) { "foo.rb" }

    describe "#guard", :capture_out, :wip do
      context "file is already there" do
        before { ignorefile_write "#{token}\n" }

        specify do
          expect( stderr_from { Ignorance.guard token } ).to be_empty
        end
      end

      context "file is not already there" do
        before { ignorefile_write "something-else.txt\n" }

        specify do
          expect( stderr_from { Ignorance.guard token } ).to match /please add "#{token}" to .*\.gitignore/
        end
      end
    end

  end

end
