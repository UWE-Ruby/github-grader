require 'octokit'
require 'highline/import'

# Look at all the students within the organization
# Look at the assignment and all the forks of it
# 
# git clone the public repository
# bundle install
# execute specs through rake

username = ask("Github Username: ", String)
password = ask("Github Password: ") do |q| 
  q.echo = "*"
end

say "Logging into Github on your behalf:"

client = Octokit::Client.new(:login => username, :password => password)

# Ruby Organization
#client.organization_teams('UWE-Ruby').inspect
# [<#Hashie::Mash id=90635 name="Fall 2011" permission="pull">, <#Hashie::Mash id=90498 name="Owners" permission="admin">]

# Team Members
# [ ... <#Hashie::Mash company="University of Washington" email="wynnburke@gmail.com" gravatar_id="006cb555a37bba6e70dd92cefa66cef1" location="Harboview" login="wynnb" name="wynn burke" type="User">]
#puts client.team_members(90635)

assignment = ask "Grade Project Name: ", String

team_members = client.team_members(90635)

def retrieve_the_assignment(member,assignment)
  say "Looking to see if #{member.login} has started #{assignment}"
  Octokit.repositories(member.login).find {|repo| repo.name == assignment }
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
  result = system "rake"
  
  say "The test results for #{location} is [#{result}]"
  
  Dir.chdir cwd
  result
end

def cleanup(location)
  say "Cleaning #{location}"
  system "rm -rf #{location}"
end

team_members.each do |member|
  
  system "ruby lib/assistant.rb #{member.login} #{assignment}"
  
end