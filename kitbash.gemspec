Gem::Specification.new do |s|
  s.name = %q{kitbash}
  s.version = "0.0.1"
  s.date = %q{2019-07-03}
  s.summary = %q{Kitbash}
  s.description = %q{Kitbash is a gem that lets you generate realistic random data}
  s.authors = ["taidaesal"]
  s.email = 'taidaesal@outlook.com'
  s.license = 'MIT'
  s.files = %w(
    lib/kitbash.rb
    lib/names/names.rb
    lib/names/bulk.rb
    lib/synonyms/synonyms.rb
    lib/synonyms/bulk.rb
    lib/kitbash/addresses.rb
    lib/kitbash/bulk.rb
    lib/kitbash/bulk/address_bulk.rb
  )
  s.require_paths = ["lib"]
end
