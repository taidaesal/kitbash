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

## Organizations

Contains code intended to generate the names of random organizations.

#### Available Methods

**default_domain** - Randomly selects a domain belonging to one of the pre-generated organizations

**default_org** - Randomly selects one of the pre-generated organizations

**gen_org_name** - Generates a random organization name based on the argument `type`. Options for `type` are:
 - :syllable - create a name from a random syllable with a "techy" suffix. This is the default
 - :nouns - Create a name from a random noun
 - :location - Create a name from a combination of nouns, adjectives, and location names
 - :words - Create a name from a combination of nouns and adjectives

**gen_org_url** - Generates a url for an organization. Takes the name of the organization as a parameter

**organization** - Generates an organization and url using previously-listed methods. Takes `type` as an argument

**random_website** - Generates a random website name

#### Example
```ruby
require 'kitbash'

puts "#{Kitbash::Organizations.organization}"
#=> {:name=>"Courus", :url=>"courus.fr.mil"}
```

## Accounts

Contains methods to help generate usernames and user emails.

**email_from_name** - Creates an email from a personal name takes a required `name` argument and an optional `domain` argument. If `domain` is not supplied, a random one will be generated

**random_email** - Generates a random email address from a combination of random words. Takes and optional `use_default_domain` argument that, if set to `true` will restrict the email domain to one of the pre-generated ones

**random_username** - Generates a random username out of a collection of random words, phrases, and years

**username_from_personal_name** - Same as `email_from_name` but without attaching a domain to the end

#### Example
```ruby
require 'kitbash'

name = Kitbash::Names.name
puts "#{name}"
#=> "Jolie Huang"
puts "#{Kitbash::Accounts.email_from_name name}"
#=> "jhuang@engineering.org"
```

## ImageGenerator

Generate simple images. All images start with a random background color and a user-specified number of simple geometric shapes are added on top of that, each with a random color. The constructor takes a width and height argument which will be used for all images generated from that class instance. This is because it's intended to be used to generate a batch of images for profile pictures or something similar. Because of this, we just go ahead and assume they should all be the same size.

#### Available Methods

Note: All methods take two arguments, an integer specifying how many geometric elements should be put on the image and a float between 0 and 1 which specifies what proportion of the width of the image can be taken up by each individual element. The default for the second argument is `0.5`.

**draw_circles** - Returns an image with circles drawn on it

**draw_random** - Returns an image with circles, rectangles, and squares drawn on it

**draw_rectangles** - Returns an image with rectangles drawn on it

**draw_squares** - Returns an image with squares drawn on it

#### Example
```ruby
require 'kitbash'

gen = Kitbash::ImageGenerator.new(500, 500)
gen.draw_circles(10).save('circles.png')
gen.draw_random(10).save('random.png')
gen.draw_rectangles(10).save('rectangles.png')
gen.draw_squares(10).save('squares.png')
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
There must be an entr point section for the program. By default, this section is `main` but you can give a custom name
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

#### Custom entry-point section
```
entry: {hello world}
```

To use `entry` as the entry point use the following ruby code:
```ruby
obj = Kitbash::TextBash.new input_argument, 'entry'
puts obj.generate
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
 * male_name_first
 * female_name
 * female_name_first
 * diminutive
 * organization
 * software
 * sports
 * studies
 * superlative
 * surname
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

### Examples
This is an example of a full test of the `TextBash` class
```ruby
require 'kitbash'
require 'securerandom'

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

Below is an example of using variables in textbash
```ruby
input = """
$boy_1 = {@male_name_first@}
$boy_2 = {John}
$girl_1 = {[girl_names]}
girl_names:{Jane | Jill}

story: {
  $girl_1$ likes $boy_1$ but unfortunately for her, $boy_1$ likes $boy_2$
}
"""

txt = Kitbash::TextBash.new input, 'story'
puts txt.generate

#=> Jill likes Myron but unfortunately for her, Myron likes John
```
