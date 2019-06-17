module Kitbash
  module Names
    require 'names/bulk'

    def Names.female_name
      first = SecureRandom.random_number(Bulk.females.count)
      last = SecureRandom.random_number(Bulk.surnames.count)
      "#{Bulk.females[first]} #{Bulk.surnames[last]}"
    end

    def Names.male_name
      first = SecureRandom.random_number(Bulk.males.count)
      last = SecureRandom.random_number(Bulk.surnames.count)
      "#{Bulk.males[first]} #{Bulk.surnames[last]}"
    end

    def Names.name
      val = SecureRandom.random_number
      if val < 0.50
        Names.male_name
      else
        Names.female_name
      end
    end

  end
end
