module Ignorance
  shared_examples "an ignore file" do

    it { should respond_to :name, :exists?, :its_a_repo?, :ignored?, :ignore! }
    it "has a name" do
      expect(subject.name).to eq(ignore_file)
    end

    describe "#exists?" do

      context "when the ignore file does NOT exist" do
        it { should_not exist }
      end

      context "when the ignore file DOES exist" do
        before { ignorefile_write "" }
        it     { should exist        }
      end

    end


    describe "#its_a_repo?" do

      context "when the repo subdirectory does NOT exist" do
        it { should_not be_its_a_repo }
      end

      context "when the repo subdirectory DOES exist" do
        before { Dir.mkdir repo_dir   }
        it     { should be_its_a_repo }
      end

    end

    describe "#ignored?" do
      let(:token) { "foofile.txt" }

      context "when the ignore file doesn't exist" do
        specify "then the file is not ignored, duh" do
          subject.should_not exist
          subject.ignored?(token).should == false
        end
      end

      context "when the ignore file does exist" do

        context "when the ignore file doesn't include the token" do
          before { ignorefile_write %w[other stuff here].join("\n") }
          it     { should_not be_ignored(token)                    }
        end

        context "when the ignore file DOES include the token" do
          before { ignorefile_write ["other", token+"", "stuff"].join("\n") }
          it     { should be_ignored(token)                                 }
        end
      end

    end


    describe "#ignore!" do
      let(:token) { "foofile.txt" }

      context "there is no ignore file" do
        it "writes to the ignore file" do
          subject.should_not exist
          subject.ignore! token
          ignored_tokens.should include token
        end
      end

      context "there is already an ignore file" do
        before { ignorefile_write "*.swp\n" }
        specify do
          ignored_tokens.should include '*.swp'
          subject.ignore! token
          ignored_tokens.should include '*.swp'
        end
      end

      context "the token is already in the ignore file" do
        let(:content) { "other\n#{token}\nstuff\n" }
        before { ignorefile_write content }

        it "doesn't write to the ignore file" do
          File.any_instance.should_not_receive(:write)
          subject.ignore!(token)
          ignored_tokens.should include token
        end
      end

      context "with a comment" do
        context "when the comment wasn't already in the file" do
          specify do
            subject.ignore! token, "# hide these files!"
            ignorefile_contents.should match(/# hide these files!\n#{token}\n/)
          end
        end

        context "when the comment was already in the file" do
          let(:comment) { "hide these files!" }

          context "comment is the last line of the file" do
            before { ignorefile_write "\n# #{comment}\n" }

            specify do
              subject.ignore! token, comment
              ignorefile_contents.should match(/# #{comment}\n#{token}\n/)
            end
          end

          context "when the comment has other tokens after it" do
            before do
              ignorefile_write <<-IGNORE
# #{comment}
barfile.md

other-things
              IGNORE
            end
            let(:expected) { Regexp.new(/# #{comment}\nbarfile\.md\n#{token}\n\nother-things/) }

            specify do
              subject.ignore! token, comment
              ignorefile_contents.should match expected
            end
          end

          context "when comment has other tokens at end of file" do
            before do
              ignorefile_write <<-IGNORE
# #{comment}
barfile.md
              IGNORE
            end
            let(:expected) { Regexp.new(/# #{comment}\nbarfile\.md\n#{token}\n/) }

            specify do
              subject.ignore! token, comment
              ignorefile_contents.should match expected
            end
          end
        end
      end
    end
  end
end

