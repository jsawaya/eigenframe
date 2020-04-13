#!ruby

puts "Content-type: text/plain; charset=iso-8859-1"
puts ""

for arg in ARGV
    puts arg
end

puts "Environment Variable Hashmap:"
ENV.each_pair do |k,v|
    puts "key: #{k}, val: #{v}" 
end
