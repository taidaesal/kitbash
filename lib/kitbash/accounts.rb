module Kitbash
  class Accounts
    @fan = %w(fan admirer buff lover supporter freak zealot)
    @master = %w(master boss god artist guru genius pro maestro)

    @random_username_forms = [
        %w(verb noun),
        %w(verb noun year),
        %w(adjective noun),
        %w(adjective noun year),
        %w(noun fan year),
        %w(adjective noun),
        %w(adjective noun year),
        %w(adjective noun fan),
        %w(adjective noun fan year),
        %w(adjective studies),
        %w(adjective studies year),
        %w(studies fan),
        %w(studies fan year),
        %w(trendy fan),
        %w(sports year),
        %w(sports fan year),
        %w(superlative sports fan),
        %w(superlative sports fan year),
        %w(trendy master),
        %w(trendy superlative master),
        %w(superlative trendy master),
        %w(software master),
        %w(software master year),
        %w(software superlative master),
        %w(software superlative master year)
    ]
    @username_separators = ['.', '_', '-', '', '', '', '', '']

    def self.email_from_name(name, domain = nil)
      domain = Kitbash::Organizations.random_website unless domain
      user = username_from_personal_name(name)
      "#{user}@#{domain}"
    end

    def self.random_email(use_default_domain = false)
      domain = if use_default_domain
        Kitbash::Organizations.default_domain
      else
        Kitbash::Organizations.random_website
      end
      "#{random_username}@#{domain}"
    end

    def self.random_username
      sep = @username_separators.sample
      pattern = @random_username_forms.sample
      ret = []
      pattern.each do |item|
        case item
        when 'verb'
          ret.push Kitbash::Organizations.verb
        when 'noun'
          ret.push Kitbash::Organizations.noun
        when 'adjective'
          ret.push Kitbash::Organizations.adjective
        when 'year'
          ret.push "#{year}"
        when 'studies'
          ret.push Kitbash::Synonyms.studies
        when 'fan'
          ret.push @fan.sample
        when 'trendy'
          ret.push Kitbash::Synonyms.trendy
        when 'sports'
          ret.push Kitbash::Synonyms.sports
        when 'superlative'
          ret.push Kitbash::Synonyms.superlative
        when 'master'
          ret.push @master.sample
        when 'software'
          ret.push Kitbash::Synonyms.software
        end
      end
      ret.map{|x| x.gsub(' ', '') }.join(sep).downcase
    end

    def self.username_from_personal_name(name)
      parsed_name = name.strip.downcase.split(' ')
      return random_username unless parsed_name.length == 2
      x = SecureRandom.random_number
      sep = @username_separators.sample
      if x < 0.45
        "#{parsed_name.join(sep)}"
      elsif x < 0.65
        "#{parsed_name[0][0,1]}#{sep}#{parsed_name[1]}"
      elsif x < 0.75
        "#{parsed_name[0]}#{sep}#{parsed_name[1][0,1]}"
      elsif x < 0.9
        "#{parsed_name.join(sep)}#{year}"
      elsif x < 0.96
        "#{parsed_name[0][0,1]}#{sep}#{parsed_name[1]}#{year}"
      else
        "#{parsed_name[0]}#{sep}#{parsed_name[1][0,1]}#{year}"
      end
    end

    private

    def self.year
      rand(71) + 1950
    end
  end
end
