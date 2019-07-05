module Kitbash
  class Names
    extend Bulk::NamesBulk

    def self.female_name
      first = SecureRandom.random_number(females.count)
      last = SecureRandom.random_number(surnames.count)
      "#{females[first]} #{surnames[last]}"
    end

    def self.male_name
      first = SecureRandom.random_number(males.count)
      last = SecureRandom.random_number(surnames.count)
      "#{males[first]} #{surnames[last]}"
    end

    def self.name
      val = SecureRandom.random_number
      if val < 0.50
        self.male_name
      else
        self.female_name
      end
    end

  end
end
