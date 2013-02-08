require 'fakefs/spec_helpers'
require File.join(File.dirname(__FILE__), 'ignorefile_helpers')
require File.join(File.dirname(__FILE__), 'io_helpers')

here = File.dirname(__FILE__)

$LOAD_PATH.unshift(File.expand_path(File.join(here, '..', '..', 'lib')))

Dir[File.join(here, "shared_examples") + "/**/*.rb"].sort.map{|f| File.basename f }.map{|f| "shared_examples/#{f}"}.each {|f| require f}

RSpec.configure do |cfg|
  cfg.treat_symbols_as_metadata_keys_with_true_values = true
  cfg.include FakeFS::SpecHelpers, fakefs: true
  cfg.include IgnorefileHelpers, fakefs: true
  cfg.include IOHelpers, capture_out: true
end
