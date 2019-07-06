module Kitbash
  class TextBash
    attr_accessor :text
    attr_accessor :sections

    # we want to capture things in the format:
    #  name:{content}
    # there can be spaces before `name` and around `:`
    # `name` must contain only alphanumeric characters or underscores
    TEXT_FORMAT = /[ ]*(\w*)[ ]*:[ ]*{([^{}]+)}/m
    # match section replacement commands of the form
    #   [section_name]
    # `section_name` must contain only alphanumeric characters or underscores
    REPLACEMENT_FORMAT = /\[([^\]]+)\]/
    # match the function execution commands of the form
    #  @function_name@
    # `function_name` must contain only alphanumeric characters or underscores
    FUNCTION_FORMAT = /@([^@]+)@/

    def initialize(txt)
      @text = txt
      @sections = {}
      process_raw
    end

    def add_method(name, method)
      define_singleton_method(name, method)
    end

    def generate
      working_text = @sections['main'][0]
      if working_text.match?(REPLACEMENT_FORMAT) || working_text.match?(FUNCTION_FORMAT)
        working_text = process_output_text working_text
      end
      working_text
    end

    private

    def add_item(cmd, opts)
      if @sections.key? cmd
        raise "Multiple sections named #{cmd}."
      end
      @sections[cmd] = []
      opts.split('|').each do |opt|
        @sections[cmd].push opt.strip
      end
    end

    def evaluate_function(fun)
      case fun
      when 'name'
        Kitbash::Names.name
      when 'male_name'
        Kitbash::Names.male_name
      when 'female_name'
        Kitbash::Names.female_name
      when 'diminutive'
        Kitbash::Synonyms.diminutive
      when 'organization'
        Kitbash::Synonyms.organization
      when 'software'
        Kitbash::Synonyms.software
      when 'sports'
        Kitbash::Synonyms.sports
      when 'studies'
        Kitbash::Synonyms.studies
      when 'superlative'
        Kitbash::Synonyms.superlative
      when 'trendy'
        Kitbash::Synonyms.trendy
      when 'user'
        Kitbash::Synonyms.user
      else
        if self.respond_to? fun
          self.send(fun)
        else
          raise "Can't find function named '#{fun}'. Note section names are case and space-sensitive."
        end
      end
    end

    def get_section_output(section)
      unless @sections.key? section
        raise "Can't find section named '#{section}'. Note section names are case and space-sensitive."
      end
      opts = @sections[section]
      ind = if opts.count > 1
        SecureRandom.random_number(opts.count)
      else
        0
      end
      opts[ind]
    end

    def process_output_text(inpt)
      continue = true
      outpt = inpt
      while continue
        inpt = outpt
        inpt.scan(REPLACEMENT_FORMAT) do |section|
          opt = get_section_output section[0]
          outpt = outpt.sub(/\[#{section[0]}\]/, "#{opt}")
        end
        inpt.scan(FUNCTION_FORMAT) do |fun|
          opt = evaluate_function fun[0]
          outpt = outpt.sub(/@#{fun[0]}@/, "#{opt}")
        end
        unless outpt.match?(REPLACEMENT_FORMAT) || outpt.match?(FUNCTION_FORMAT)
          continue = false
        end
      end
      outpt
    end

    def process_raw
      @text.scan(TEXT_FORMAT) { |cmd, opt| add_item(cmd.strip, opt.strip) }
      unless @sections.key? 'main'
        raise 'Missing "main" section. Note that section names are case-sensitive.'
      end
    end
  end
end
