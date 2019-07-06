# kitbash

This gem is intended to be used to help generate believable data, with a focus on PII (Personally Identifiable Information) like Names, Emails, and addresses. The data generated this way is not "real" in the sense of actually reflecting real PII, but is simply intended to look like it *could* be real data. The motivation behind this is a need to generate demo data for a program that handles PII that I'm responsible for at work. Using this, realistic data can be generated that can be used to demo the software to clients without risking exposing real data or displaying some programmer's idea of "humorous" example data at an inopportune time.

Given the nature of this program it's possible that data could be generated using this gem that coincidentally looks like the PII of a real person. So consider this a disclaimer that nothing output by this program is intended to reflect any real-world information or the PII of any individual living or dead.

## Names

This module generates random names in the Western format of personal name first followed by family name. These names are culled from lists of well-known figures as well as lists of most common names from a number of different countries. When a random name is requested, a personal name and surname is selected from the list at random. Certain names that are either gender-neutral or are used for different genders in different cultures may show up on either list.

#### Available Methods
**female_name** - Generates a random female name.

**male_name** - Generates a random male name.

**name** - Generates a random name of either gender.

#### Example
```ruby
require 'kitbash'

puts "#{Kitbash::Names.male_name}"
#=> Collin Tikhonov
```

## Addresses

Produce addresses in the format used by the US. Adding UK and Canadian addresses might be a future target

#### Available Methods

**random_addr** - Random US address. Takes two bools, the first one controls whether the output is formated. The second controls whether the city is accurate to the state

**random_city_state** - Get a random state, city, and zip. Zip code is accurate to the state. Takes a bool that controls whether the city is accurate to the state

**random_street_addr** - Get a random street address

#### Example
```ruby
require 'kitbash'

addr = Kitbash::Addresses.random_addr
puts "#{addr[0]}"
puts "#{addr[1]}"
#=> 2635 SW Pacific Lamprey Lane DR
#=> Temecula, TX 79679
```

## Synonyms

Lists of words that might be useful when bashing random descriptions or user bios together

#### Available Methods

**diminutive** - Random word implying small or weak

**organization** - Random word that can be used in place of "organization"

**software** - Random software name

**sports** - Random sport name

**studies** - Random name of an academic field of study

**superlatives** - Random word implying great or large

**trendy** - Random over-used trendy tech term

**user** - Random word that can be used to mean "user" or "person"

#### Example
```ruby
require 'kitbash'

puts "#{Kitbash::Synonyms.trendy}"
#=> blockchain
```

## TextBash

Accept text templates to generate algorithmic variations.

#### Sections
The basic structure is a list of sections. A section is defined as
```
section_name:{section content}
```
In the above example, `section_name` can include any alphanumeric character as well as `_`. There can be spaces around `:` as well as after the `{` or before the `}`. In this example, `section content` is what would be substituted when `section_name` is invoked.

#### Multiple choice content
In the last section we looked at a section with a single string it could resolve to, `section content`, but it is possible to define sections which have multiple ways to be resolved. For example:
```
section_name:{one | two | three}
```
each time `section_name` is invoked it will resolve to either `one`, `two`, or `three`. There does not need to be spaces around the `|` but it improves readability. When the input is processed these extra spaces are removed.

#### Invoking sections
A section can be invoked inside another section by putting the section's name inside `[]`. For example:
```
section_one:{world}
section_two:{hello [section_one]}
```
This above example will resolve to `hello world`. Note that when invoking a section it is sensitive to spaces and capitalization. So the following three invocations are not equivalent.
```
[section_name]
[ section_name]
[Section_Name]
```

#### Main section
There must be a section named `main` where evaluation will start. For example:
```
opening:{hello | greetings}
main: {[opening] world!}
```
This code will evaluate to either `hello world!` or `greetings world!`

the main section can not contain any "|" characters. If it does, only the first part is used
```
main:{first part | second part}
```
Will always evaluate to be equivalent to
```
main:{first part}
```


#### Nested invocations
Any section can invoke any other section. For example, the code in the last section could also be written as:
```
opening:{hello | greetings}
phrase:{[opening] world!}
main:{[phrase]}
```
This can be nested as deeply as desired.

#### Functions
Functions can be invoked within any of the sections by calling the function name inside `@...@`. For example:
```
with_function:{hello from the function: @foo@}
```

#### Default functions
This supports default functions provided by `Kitbash::Names` and `Kitbash::Synonyms`. So you can make code like:
```
main:{Hello @male_name@!}
```
This might evaluate to `Hello Mathys Loginov!`

The full list of method names are as follows
 * name
 * male_name
 * female_name
 * diminutive
 * organization
 * software
 * sports
 * studies
 * superlative
 * trendy
 * user

#### Custom functions
Custom functions can be created as lambdas and passed to the `TextBash` object with the `add_method` method
```ruby
input_string = """
  main: {random_number: @print_rand@}
"""

cmd = Kitbash::TextBash.new input_string

custom_function = -> do
  SecureRandom.random_number(100)
end

cmd.add_method 'print_rand', custom_function

cmd.generate

#=> "random_number: 27"
```

### Example
This is an example of a full test of the `TextBash` class
```ruby
local_function = -> do
    SecureRandom.random_number(100)
end

input_argument = """
arg_a: {one}
arg_b: {two}
arg_c: {[arg_a] | [arg_b]}
arg_d: {phrase one | phrase two | phrase three | phrase four | phrase five | phrase six | phrase seven | phrase eight | phrase nine | phrase ten}
name_args: {@male_name@ | @female_name@}
main: {
  Hello [name_args], I hope you're having a @superlative@ day learning about @trendy@. This is
arg_a \"[arg_a]\" and this is arg_c \"[arg_c]\". Now here we have arg_d \"[arg_d]\" and a second arg_d \"[arg_d]\".

random number: @local_function@
}
"""

obj = Kitbash::TextBash.new input_argument
obj.add_method('local_function', local_function)
puts obj.generate

#=> Hello Alannah Dupre, I hope you're having a perfect day learning about blockchain. This is
#=> arg_a "one" and this is arg_c "two". Now here we have arg_d "phrase eight" and a second arg_d "phrase two".
#=>
#=> random number: 5
```
