shared_examples "a project-oriented VCS" do

  describe "#its_a_repo?", :fakefs do
    context "pwd is a subdirectory of the repo root" do
      before do
        mk_repo_dir
        Dir.mkdir 'lib'
        Dir.mkdir 'lib/other'
        Dir.chdir 'lib/other'
      end

      it { should be_its_a_repo }
    end

    context "pwd is not the subdirectory of any repo" do
      before do
        Dir.mkdir 'lib'
        Dir.mkdir 'lib/other'
        Dir.chdir 'lib/other'
      end

      it { should_not be_its_a_repo }
    end
  end

end
