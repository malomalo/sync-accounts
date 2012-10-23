users = {}
Dir.entries('users').select{|f| File.file?("users/#{f}") }.each do |u|
  users[u] = File.readlines("users/#{u}").map{|l| l.strip}.select{|l| !l.empty? }
end

groups = {}
Dir.entries('groups').select{|f| File.file?("groups/#{f}") }.each do |g|
  members = File.readlines("groups/#{g}").map{|l| l.strip}.select{|l| !l.empty? }
  groups[g] = members.map{ |u| users[u] }.flatten
end

system_users = `cat /etc/passwd | grep -v root | grep '/bin/bash'`.split
system_users.map! do |u|
  u =~ /(\w+):.*:.*:.*:.*:([a-zA-Z\/]+):\/bin\/bash$/
  {:name => $1, :home => $2}
end

system_users.each do |su|
  if users[su[:name]]
    puts "USER: #{su[:name]}"
    puts "  filename: #{su[:home]}"
    puts users[su[:name]].join("\n")+"\n"
  elsif groups[su[:name]]
    puts "GROUP: #{su[:name]}"
    puts "  filename: #{su[:home]}"
    puts groups[su[:name]].join("\n")+"\n"
  end
end
