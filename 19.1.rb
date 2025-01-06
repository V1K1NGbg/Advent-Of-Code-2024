# ruby 19.1.rb

def solution?(design, towels_by_start)
    return true if design.empty?
  
    potential_towels = towels_by_start.fetch(design[0], [])
  
    matching_towels = potential_towels.select { |towel| design.start_with?(towel) }
    return false if matching_towels.empty?
  
    matching_towels.any? do |towel|
      remaining_design = design[towel.size..]
      solution?(remaining_design, towels_by_start)
    end
  end
  
  input_file = "input/19.txt"
  lines = File.readlines(input_file)
  
  towels = lines.first.split(',').map(&:strip)
  designs = lines[2..].map(&:strip)
  towels_by_start = towels.group_by { |t| t[0] }
  
  solutions = []
  designs.each do |design|
    solutions << design if solution?(design, towels_by_start)
  end
  
  puts solutions.size