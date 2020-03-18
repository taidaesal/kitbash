module Kitbash
  class Names
    extend Bulk::NamesBulk

    def self.female_name
      "#{females.sample} #{surnames.sample}"
    end

    def self.female_name_first
      females.sample
    end

    def self.male_name
      "#{males.sample} #{surnames.sample}"
    end

    def self.male_name_first
      males.sample
    end

    def self.name
      val = SecureRandom.random_number
      if val < 0.50
        self.male_name
      else
        self.female_name
      end
    end

    def self.surname
      surnames.sample
    end
  end
end
