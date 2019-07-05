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

**diminutives** - Random word implying small or weak

**organizations** - Random word that can be used in place of "organization"

**software** - Random software name

**sports** - Random sport name

**studies** - Random name of an academic field of study

**superlatives** - Random word implying great or large

**trendy** - Random over-used trendy tech term

**users** - Random word that can be used to mean "user" or "person"

#### Example
```ruby
require 'kitbash'

puts "#{Kitbash::Synonyms.trendy}"
#=> blockchain
```

## TextBash

Accept text templates to generate algorithmic variations

## Images

Generate images that can be used as thumbnails or user icons

Right now this is just an interesting idea that may or may not pan out. But it would be nice to be able to generate simple images to provide a bit of visual variety.

Examples might include a user silhouette against an optional geometric shape against a background. Each of these three elements would be a randomly-selected color (maybe introduce a simple color-wheel scheme to keep anything too garish from happening?)
