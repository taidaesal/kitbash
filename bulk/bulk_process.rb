require 'csv'
require 'json'

@male_names = []
@female_names = []
@surnames = []

@studies = []
@sports = []
@software = []

@zips = []
@cities = {}
@all_cities = [ # init with some of the most common names
  'Washington',
  'Springfield',
  'Franklin',
  'Lebanon',
  'Clinton',
  'Greenville',
  'Bristol',
  'Fairview',
  'Salem',
  'Madison',
  'Georgetown',
  'Arlington',
  'Ashland',
  'Dover',
  'Oxford',
  'Jackson',
  'Burlington',
  'Manchester',
  'Milton',
  'Newport',
  'Auburn',
  'Centerville',
  'Clayton',
  'Dayton',
  'Lexington',
  'Milford',
  'Mount Vernon',
  'Oakland',
  'Winchester',
  'Cleveland',
  'Hudson',
  'Kingston',
  'Riverside',
  'Peoria'
]
@streets = []
@street_modifiers = [
  'View',
  'Center',
  'Hills',
  'Way',
  'Lane',
  'Lake',
  'Woods',
  'Heights',
  'Park'
]
@directions = [
  'N',
  'S',
  'E',
  'W',
  'NE',
  'SE',
  'SW',
  'NW',
]

def string_to_sym(str)
  str.strip.downcase.gsub(' ', '_').to_sym
end

def get_ending(num)
  if (11..13).include?(num % 100)
    "th"
  else
    case num % 10
    when 1; "st"
    when 2; "nd"
    when 3; "rd"
    else    "th"
    end
  end
end

def ordinalize(num)
  "#{num}#{get_ending num}"
end

File.open('male_single.txt', 'r') do |content|
  content.each do |line|
    parsed_line = line.strip
    parsed_line = parsed_line.capitalize
    unless @male_names.include?(parsed_line) || parsed_line.empty?
      @male_names.push parsed_line
    end
  end
end

File.open('male.txt', 'r') do |content|
  content.each do |line|
    parsed_line = line.strip
    names = parsed_line.split(' ')
    if names.length > 1
      first = names[0]
      last = names.last
      first = first.capitalize
      last = last.capitalize
      unless @male_names.include?(first) || first.empty?
        @male_names.push first
      end
      unless @surnames.include?(last) || last.empty?
        @surnames.push last
      end
    end
  end
end

File.open('female_single.txt', 'r') do |content|
  content.each do |line|
    parsed_line = line.strip
    parsed_line = parsed_line.capitalize
    unless @female_names.include?(parsed_line) || parsed_line.empty?
      @female_names.push parsed_line
    end
  end
end

File.open('female.txt', 'r') do |content|
  content.each do |line|
    parsed_line = line.strip
    names = parsed_line.split(' ')
    if names.length > 1
      first = names[0]
      last = names.last
      first = first.capitalize
      last = last.capitalize
      unless @female_names.include?(first) || first.empty?
        @female_names.push first
      end
      unless @surnames.include?(last) || last.empty?
        @surnames.push last
      end
    end
  end
end

File.open('surname.txt', 'r') do |content|
  content.each do |line|
    parsed_line = line.strip
    parsed_line = parsed_line.capitalize
    unless @surnames.include?(parsed_line) || parsed_line.empty?
      unless parsed_line.gsub('.','').length < 2
        @surnames.push parsed_line
      end
    end
  end
end

File.open('studies.txt', 'r') do |content|
  content.each do |line|
    parsed_line = line.strip
    parsed_line = parsed_line.capitalize
    unless @studies.include?(parsed_line) || parsed_line.empty?
      @studies.push parsed_line
    end
  end
end

File.open('sports.txt', 'r') do |content|
  content.each do |line|
    parsed_line = line.strip
    parsed_line = parsed_line.capitalize
    unless @sports.include?(parsed_line) || parsed_line.empty?
      @sports.push parsed_line
    end
  end
end

File.open('software.txt', 'r') do |content|
  content.each do |line|
    parsed_line = line.strip
    unless @software.include?(parsed_line) || parsed_line.empty?
      @software.push parsed_line
    end
  end
end

CSV.foreach('states_zips.csv', headers: true) do |line|
  @zips.push(
    {
      state_name: line['State Name'],
      state_sym: string_to_sym(line['State Name']),
      state_abbr: line['ST'],
      zip_min: line['Zip Min'].to_i,
      zip_max: line['Zip Max'].to_i
    }
  )
end

CSV.foreach('state_cities.csv') do |line|
  state = string_to_sym(line[1])
  unless @cities.key?(state)
    @cities[state] = []
  end
  unless @all_cities.include?(line[0].strip)
    @all_cities.push line[0].strip
  end
  @cities[state].push(line[0].strip)
end

# generating street names is a bit more involved
(1..152).each do |num|
  numeric = ordinalize(num)
  @streets.push "#{numeric}"
  @directions.each do |dir|
    @streets.push "#{dir} #{numeric}"
  end
end

File.open('streets.txt', 'r') do |content|
  content.each do |line|
    dat = line.strip
    @streets.push dat
    @directions.each do |dir|
      @streets.push "#{dir} #{dat}"
    end
    @street_modifiers.each do |mod|
      @streets.push "#{dat} #{mod}"
      @directions.each do |dir|
        @streets.push "#{dir} #{dat} #{mod}"
      end
    end
  end
end

@male_names = @male_names.shuffle.shuffle
@female_names = @female_names.shuffle.shuffle
@surnames = @surnames.shuffle.shuffle
@studies = @studies.shuffle.shuffle
@sports = @sports.shuffle.shuffle
@software = @software.shuffle.shuffle

if false
  File.open('../lib/kitbash/bulk/names_bulk.rb', 'w') do |file|
    file.puts 'module Kitbash'
    file.puts '  module Bulk'
    file.puts '    module NamesBulk'

    file.puts '      def males'
    file.puts '        @@males ||= %w('
    @male_names.each do |name|
      file.puts "          #{name}"
    end
    file.puts '        )'
    file.puts '      end'

    file.puts "\n\n"

    file.puts '      def females'
    file.puts '        @@females ||= %w('
    @female_names.each do |name|
      file.puts "          #{name}"
    end
    file.puts '        )'
    file.puts '      end'

    file.puts "\n\n"

    file.puts '      def surnames'
    file.puts '        @@surnames ||= %w('
    @surnames.each do |name|
      file.puts "          #{name}"
    end
    file.puts '        )'
    file.puts '      end'

    file.puts '    end'
    file.puts '  end'
    file.puts 'end'
  end
end

if true
  File.open('../lib/kitbash/bulk/synonym_bulk.rb', 'w') do |file|
    file.puts 'module Kitbash'
    file.puts '  module Bulk'
    file.puts '    module SynonymBulk'

    file.puts '      def sport_names'
    file.puts '        @@sport_names ||= ['
    @sports.each do |word|
      file.puts "          \"#{word}\","
    end
    file.puts '        ]'
    file.puts '      end'

    file.puts "\n\n"

    file.puts '      def software_names'
    file.puts '        @@software_names ||= ['
    @software.each do |word|
      file.puts "          \"#{word}\","
    end
    file.puts '        ]'
    file.puts '      end'

    file.puts "\n\n"

    file.puts '      def study_name'
    file.puts '        @@study_name ||= ['
    @studies.each do |word|
      file.puts "          \"#{word}\","
    end
    file.puts '        ]'
    file.puts '      end'

    file.puts '    end'
    file.puts '  end'
    file.puts 'end'
  end
end

if false
  File.open('../lib/kitbash/bulk/address_bulk.rb', 'w') do |file|
    file.puts 'module Kitbash'
    file.puts '  module Bulk'
    file.puts '    module AddressBulk'

    file.puts '      def all_cities'
    file.puts "        @@all_cities ||= #{JSON.pretty_generate @all_cities}"
    file.puts '      end'

    file.puts ''
    file.puts ''

    file.puts '      def cities'
    file.puts "        @@cities ||= #{JSON.pretty_generate @cities}"
    file.puts '      end'

    file.puts ''
    file.puts ''

    file.puts '      def streets'
    file.puts "        @@streets ||= #{JSON.pretty_generate @streets}"
    file.puts '      end'

    file.puts ''
    file.puts ''

    file.puts '      def zip_codes'
    file.puts "        @@zip_codes ||= #{JSON.pretty_generate @zips}"
    file.puts '      end'

    file.puts '    end'
    file.puts '  end'
    file.puts 'end'
  end
end

puts "Male Names: #{@male_names.count}"
puts "Female Names: #{@female_names.count}"
puts "Surnames: #{@surnames.count}"
puts "Options: #{(@male_names.count * @surnames.count) + (@female_names.count * @surnames.count)}"

puts ''
puts ''
puts "Sports Options: #{@sports.count}"
puts "Studies Options: #{@studies.count}"
puts "Software Options: #{@software.count}"

puts ''
puts ''
puts "states with cities: #{@cities.count}"
puts "cities: #{@all_cities.count}"
puts "streets: #{@streets.count}"
