require 'octokit'
require 'highline/import'

member = ARGV[0]
assignment = ARGV[1]


def retrieve_the_assignment(member,assignment)
  say "Looking to see if #{member} has started #{assignment}"
  Octokit.repositories(member).find {|repo| repo.name == assignment }
end

def download(assignment)
  say "Attempting to download #{assignment.owner.login}'s #{assignment.name}"
  download_location = "#{assignment.owner.login}-#{assignment.name}"
  system "git clone #{assignment.ssh_url} #{download_location}"
  download_location
end

def prepare(location)
  say "Preparing #{location}"
  cwd = Dir.getwd
  Dir.chdir location
  system "rm Gemfile.lock"
  system "bundle"
  Dir.chdir cwd
end

def test(location)
  say "Testing #{location}"
  cwd = Dir.getwd
  Dir.chdir location
  result = system "rspec spec -c"
  
  say "The test results for #{location} is [#{result}]"
  
  Dir.chdir cwd
  result
end

def cleanup(location)
  say "Cleaning #{location}"
  system "rm -rf #{location}"
end


if member_assigment = retrieve_the_assignment(member,assignment)
  
  downloaded_assignment = download member_assigment
  prepare downloaded_assignment
  
  if test downloaded_assignment
    cleanup downloaded_assignment
  else
    say %{
================================================================================
#{member} has failing tests please check their assignment #{assignment}
================================================================================}
  end
else
  say %{
================================================================================
#{member} has not started the assignment #{assignment}
================================================================================}
end