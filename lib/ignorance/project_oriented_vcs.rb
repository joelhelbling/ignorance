module Ignorance
  module ProjectOrientedVCS

    def its_a_repo?
      path = Dir.getwd.scan(/\/[^\/]+/).map{|p| p[1..-1]}
      repo_found = false
      until (repo_found = Dir.exists?(File.join("/", path, @repo_dir))) || path.empty?
        path.pop
      end
      repo_found
    end

  end
end
