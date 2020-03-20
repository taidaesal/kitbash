module Kitbash
  class Organizations
    extend Bulk::OrganizationsBulk

    @domains = %w(
      org
      com
      mil
      gov
      edu
      ly
      it
      info
      net
      int
    )
    @mid_domain = %w(
      us
      uk
      cc
      au
      de
      su
      jp
      fr
      eu
      co
    )

    @common_org_endings = %w(
      tech
      tek
      OS
      alia
      soft
      mart
      way
      on
      CO
      co
      tel
      conn
      nol
      flix
      path
      rus
      touch
      ro
      city
      app
      pop
      port
      cast
    )

    @syllable_forms = [%w(v c v), %w(v c c), %w(c v), %w(c v c), %w(c v v)]

    @consonants = %w(b c d f g h j k l m n p q r s t v w x z)
    @vowels = %w(a e i o u y)

    def self.default_domain
      default_orgs.sample[:url]
    end

    def self.default_org
      default_orgs.sample
    end

    def self.gen_org_name(type = :syllable)
      ret = ''
      if type == :syllable
        form = @syllable_forms.sample
        form.each do |x|
          if x == 'v'
            ret = "#{ret}#{@vowels.sample}"
          else
            ret = "#{ret}#{@consonants.sample}"
          end
        end
        ret = "#{ret}#{@common_org_endings.sample}"
      elsif type == :nouns
        x = SecureRandom.random_number
        if x < 0.11
          ret = "#{noun} #{@common_org_endings.sample}"
        elsif x < 0.5
          ret = "#{noun} #{Kitbash::Synonyms.organization}"
        else
          ret = noun
        end
      elsif type == :location
        x = SecureRandom.random_number
        loc = Kitbash::Addresses.random_city_state
        location = if x < 0.5
          loc[:city]
        else
          loc[:state]
        end
        x = SecureRandom.random_number
        if x < 0.15
          ret = "#{Kitbash::Synonyms.superlative} #{location}"
        elsif x < 0.4
          ret = "#{Kitbash::Synonyms.superlative} #{location} #{Kitbash::Synonyms.organization}"
        elsif x < 0.6
          ret = "#{location} #{Kitbash::Synonyms.organization}"
        elsif x < 0.9
          ret = "#{location} #{@common_org_endings.sample}"
        else
          ret = "#{adjective} #{location}"
        end
      elsif type == :words
        x = SecureRandom.random_number
        if x < 0.25
          ret = "#{verb} #{adjective}"
        elsif x < 0.5
          ret = "#{adjective} #{Kitbash::Synonyms.organization}"
        elsif x < 0.7
          ret = "#{adjective} #{noun}"
        else
          ret = "#{adjective} #{noun} #{@common_org_endings.sample}"
        end
      else
        ret = default_org_name
      end
      ret = ret.split.map(&:capitalize).join(' ')
      if ret.length > 3
        ret
      else
        gen_org_name(type)
      end
    end

    def self.gen_org_url(name)
      name = name.strip.downcase
      parsed_name = name.split(' ')
      domain = Kitbash::Accounts.website_domain
      x = SecureRandom.random_number
      if parsed_name.count == 1
        "#{name}#{domain}"
      elsif parsed_name.count == 2
        if x < 0.15
          "#{name.gsub(' ', '_')}#{domain}"
        elsif x < 3.5
          "#{name.gsub(' ', '.')}#{domain}"
        else
          "#{name.gsub(' ', '')}#{domain}"
        end
      else
        if x < 0.1
          "#{name.gsub(' ', '')}#{domain}"
        elsif x < 0.15
          "#{parsed_name[0]}#{parsed_name[1]}#{domain}"
        elsif x < 0.55
          "#{parsed_name[1]}#{parsed_name[2]}#{domain}"
        elsif x < 0.65
          y = "#{parsed_name[1]}#{parsed_name[2]}"
          "#{y.slice(rand(y.length), rand(y.length - 1 ) + 1)}#{domain}"
        else
          ret = ''
          parsed_name.each do |element|
            ret = "#{ret}#{element.strip()[0,1]}"
          end
          ret = "#{ret.upcase}#{domain}"
          if ret.length > 5
            ret
          else
            gen_org_url(name)
          end
        end
      end
    end

    def self.organization(type = :syllable)
      name = gen_org_name(type)
      url = gen_org_url(name)
      {name: name, url: url}
    end

    def self.random_website
      x = SecureRandom.random_number
      if x < 0.1
        "#{default_domain}"
      elsif x < 0.25
        "#{verb}#{noun}#{website_domain}".downcase
      elsif x < 0.65
        "#{adjective}#{noun}#{website_domain}".downcase
      else
        "#{noun}#{website_domain}".downcase
      end
    end

    protected

    def self.adjective
      adjectives.sample
    end

    def self.default_org_name
      default_orgs.sample['name']
    end

    def self.noun
      nouns.sample
    end

    def self.verb
      verbs.sample
    end

    def self.website_domain
      x = SecureRandom.random_number
      if x < 0.25
        ".#{@mid_domain.sample}.#{@domains.sample}"
      else
        ".#{@domains.sample}"
      end
    end
  end
end
