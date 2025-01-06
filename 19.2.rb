# ruby 19.2.rb

def acount(suffix: design, towels:, count_cache: {})
  return 1 if suffix.empty?
  return count_cache[suffix] if count_cache.key?(suffix)

  match = towels.select { |towel| suffix.start_with?(towel) }
  return 0 if match.empty?

  result = match.sum do |towel|
    rest = suffix[towel.size..]
    acount(suffix: rest, towels:, count_cache:)
  end

  count_cache[suffix] = result
  result
end

input_file = "input/19.txt"
lines = File.readlines(input_file)

towels = lines.first.split(',').map(&:strip)
designs = lines[2..].map(&:strip)

counta = 0

designs.each do |design|
  count = acount(suffix: design, towels:)
  if count > 0
    counta += count
  end
end
puts counta
