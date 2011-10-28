

task :default do
  system "ruby lib/grader.rb"
end


namespace :clean do
  ("01".."09").each do |week|
    task "week#{week}" do
      system "rm -rf *-week-#{week}"
      system "rm -rf *-week-#{week}-missing"
    end
  end
end


