@male_names = []
@female_names = []
@surnames = []

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

@male_names = @male_names.shuffle.shuffle
@female_names = @female_names.shuffle.shuffle
@surnames = @surnames.shuffle.shuffle

File.open('bulk.rb', 'w') do |file|
  file.puts 'module Kitbash'
  file.puts '  module Names'
  file.puts '    module Bulk'

  file.puts '      @male = %w('
  @male_names.each do |name|
    file.puts "        #{name}"
  end
  file.puts "      )\n\n"

  file.puts '      @female = %w('
  @female_names.each do |name|
    file.puts "        #{name}"
  end
  file.puts "      )\n\n"

  file.puts '      @surname = %w('
  @surnames.each do |name|
    file.puts "        #{name}"
  end
  file.puts "      )\n\n"

  file.puts '      def Bulk.males'
  file.puts '        @male'
  file.puts '      end'

  file.puts "\n\n"

  file.puts '      def Bulk.females'
  file.puts '        @female'
  file.puts '      end'

  file.puts "\n\n"

  file.puts '      def Bulk.surnames'
  file.puts '        @surname'
  file.puts '      end'

  file.puts '    end'
  file.puts '  end'
  file.puts 'end'
end

puts "Male Names: #{@male_names.count}"
puts "Female Names: #{@female_names.count}"
puts "Surnames: #{@surnames.count}"
puts "Options: #{(@male_names.count * @surnames.count) + (@female_names.count * @surnames.count)}"
