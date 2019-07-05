module Kitbash
  class Addresses
    extend Bulk::AddressBulk

    @@street_types = [
      "ALY",
      "ANX",
      "ARC",
      "AVE",
      "BLF",
      "BTM",
      "BLVD",
      "BRG",
      "BRK",
      "BG",
      "BYP",
      "CSWY",
      "CTR",
      "CIR",
      "CLF",
      "CLB",
      "CT",
      "CRST",
      "XING",
      "CURV",
      "DV",
      "DR",
      "ESTS",
      "EXT",
      "FLS",
      "FRY",
      "FLD",
      "FRD",
      "FRST",
      "FRG",
      "FRK",
      "FT",
      "FWY",
      "GRN",
      "GRV",
      "HBR",
      "HVN",
      "HTS",
      "HWY",
      "HL",
      "IS",
      "LNDG",
      "LOOP",
      "MALL",
      "MTWY",
      "PARK",
      "PKWY",
      "PASS",
      "PATH",
      "PT",
      "PRT",
      "PR",
      "RADL",
      "RNCH",
      "RPD",
      "RIV",
      "RD",
      "ROW",
      "RUN",
      "SKWY",
      "SPUR",
      "ST",
      "TUNL",
      "TPKE",
      "VLY",
      "WALK",
      "WALL",
      "WAY",
    ]

    # random US street address. Pass false to get raw data hash
    def self.random_addr(formatted = true, limit_cities = false)
      first_line = self.random_street_addr
      second_line = self.random_city_state limit_cities
      if formatted
        ["#{first_line[:house_num]} #{first_line[:street_name]} #{first_line[:street_type]}",
        "#{second_line[:city]}, #{second_line[:abbrv]} #{second_line[:zip]}"
        ]
      else
        [first_line, {city: second_line[:city], state: second_line[:abbrv], zip: second_line[:zip]}]
      end
    end

    # pass `true` to restrict cities to cites inside the identified state
    def self.random_city_state(accurate_city = false)
      zip = self.random_zip
      cit = if accurate_city
        self.city_in_state zip[:state_sym]
      else
        self.random_city
      end

      zip_max = zip[:zip_max] - zip[:zip_min]

      code = if zip_max > 1
        SecureRandom.random_number(zip_max) + zip[:zip_min]
      else
        zip[:zip_max]
      end

      {city: cit, state: zip[:state_name], abbrv: zip[:state_abbr], zip: code}
    end

    def self.random_street_addr
      house = SecureRandom.random_number 5000
      name = self.random_street
      typ = self.random_street_type
      {house_num: house, street_name: name, street_type: typ}
    end

    private

    def self.city_in_state(key)
      if cities.key?(key.to_sym)
        lst = cities[key.to_sym]
        ind = SecureRandom.random_number(lst.count)
        lst[ind]
      else
        self.random_city
      end
    end

    def self.random_city
      ind = SecureRandom.random_number(all_cities.count)
      all_cities[ind]
    end

    def self.random_street
      ind = SecureRandom.random_number(streets.count)
      streets[ind]
    end

    def self.random_street_type
      ind = SecureRandom.random_number @@street_types.count
      @@street_types[ind]
    end

    def self.random_zip
      ind = SecureRandom.random_number(zip_codes.count)
      zip_codes[ind]
    end
  end
end
