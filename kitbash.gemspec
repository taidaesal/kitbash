Gem::Specification.new do |s|
  s.name = %q{kitbash}
  s.version = "1.2.1"
  s.date = %q{2020-03-18}
  s.summary = %q{Kitbash}
  s.homepage = %q{https://github.com/taidaesal}
  s.description = %q{Kitbash is a gem that lets you generate realistic random data}
  s.authors = ["taidaesal"]
  s.email = 'taidaesal@outlook.com'
  s.license = 'MIT'
  s.files = %w(
    lib/kitbash.rb
    lib/kitbash/names.rb
    lib/kitbash/synonyms.rb
    lib/kitbash/addresses.rb
    lib/kitbash/bulk.rb
    lib/kitbash/text_bash.rb
    lib/kitbash/image_generator.rb
    lib/kitbash/bulk/address_bulk.rb
    lib/kitbash/bulk/names_bulk.rb
    lib/kitbash/bulk/synonym_bulk.rb
  )
  s.require_paths = ["lib"]
  s.add_runtime_dependency 'chunky_png', '~> 1.3', '>= 1.3.11'
end
