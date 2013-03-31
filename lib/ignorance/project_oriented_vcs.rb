module Ignorance
  module ProjectOrientedVCS

    def its_a_repo?
      Pathname.new(Dir.getwd).ascend do |path|
        break true if Dir.exists?(File.join(path, @repo_dir))
      end
    end

  end
end
