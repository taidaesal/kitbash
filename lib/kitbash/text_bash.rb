module Kitbash
  class TextBash
    attr_accessor :text
    attr_accessor :sections
    attr_accessor :main_section
    attr_accessor :variables

    # we want to capture things in the format:
    #  name:{content}
    # there can be spaces before `name` and around `:`
    # `name` must contain only alphanumeric characters or underscores
    TEXT_FORMAT = /[ ]*(\w*)[ ]*:[ ]*{([^{}]+)}/m
    # we want to capture things in the format
    #   $variable = {content}
    # there can be spaces before `variable` and around `=`
    # `variable` must contain only alphanumeric characters or underscores
    VARIABLE_DECLARATON_FORMAT = /[ ]*\$([\w]*)[ ]*=[ ]*{([^{}]+)}/m
    # match section replacement commands of the form
    #   [section_name]
    # `section_name` must contain only alphanumeric characters or underscores
    REPLACEMENT_FORMAT = /\[([^\]]+)\]/
    # match the function execution commands of the form
    #  @function_name@
    # `function_name` must contain only alphanumeric characters or underscores
    FUNCTION_FORMAT = /@([^@]+)@/
    # match the variables of the form
    #   $variable_name$
    #   `variable_name` must contain only alphanumeric characters or underscores
    VARIABLE_FORMAT = /\$([\w]+)\$/

    def initialize(txt, start_section = 'main')
      @text = txt
      @main_section = start_section
      @sections = {}
      @variables = {}
      process_raw
    end

    def add_method(name, method)
      define_singleton_method(name, method)
    end

    def generate
      working_text = @sections[@main_section][0]
      if !working_text
        working_text
      elsif working_text.match?(REPLACEMENT_FORMAT) || working_text.match?(FUNCTION_FORMAT) || working_text.match?(VARIABLE_FORMAT)
        process_output_text working_text
      else
        working_text
      end
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
      when 'male_name_first'
        Kitbash::Names.male_name_first
      when 'female_name'
        Kitbash::Names.female_name
      when 'female_name_first'
        Kitbash::Names.female_name_first
      when 'surname'
        Kitbash::Names.surname
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
          raise "Can't find function named '#{fun}'. Note function names are case and space-sensitive."
        end
      end
    end

    def evaluate_variable(var)
      if @variables.key? var
        @variables[var]
      else
        raise "Variable '#{var}' not defined. Define them by placing the code "
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
        inpt.scan(VARIABLE_FORMAT) do |var|
          opt = evaluate_variable var[0]
          outpt = outpt.sub(/\$#{var[0]}\$/, "#{opt}")
        end
        unless outpt.match?(REPLACEMENT_FORMAT) || outpt.match?(FUNCTION_FORMAT)
          continue = false
        end
      end
      outpt
    end

    def process_raw
      @text.scan(TEXT_FORMAT) { |cmd, opt| add_item(cmd.strip, opt.strip) }
      @text.scan(VARIABLE_DECLARATON_FORMAT) { |var, val| process_variable(var.strip, val.strip) }
      unless @sections.key? "#{@main_section}"
        raise "Start section, '#{@main_section}', missing. Note that section names are case-sensitive."
      end
    end

    def process_variable(var, val)
      @variables[var] = process_output_text val
    end
  end
end
