spec = Gem::Specification.new do |s|
  s.name = 'fcomposer'
  s.version = '0.0.2'
  s.summary = 'fcomposer is a ruby framework for (western) music composition.'
  s.description = %{fcomposer is a set of classes for assisting developers to create applications with music notation support.}
  s.files = Dir['lib/fcomposer.rb'] + Dir['lib/fcomposer/*.rb'] + Dir['lib/generators/*.rb'] + Dir['test/*.rb']
  s.test_files = ["test_fcomposer.rb"]
  s.has_rdoc = true
  s.author = "Francisco Tufro"
  s.email = "contacto@franciscotufro.com.ar"
  s.homepage = "http://fcomposer.franciscotufro.com.ar"
end
