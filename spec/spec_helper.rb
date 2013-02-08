require 'fakefs/spec_helpers'
require File.join(File.dirname(__FILE__), 'ignorefile_helpers')

$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib')))

require 'shared_examples/for_ignore_files'

RSpec.configure do |cfg|
  cfg.treat_symbols_as_metadata_keys_with_true_values = true
  cfg.include FakeFS::SpecHelpers, fakefs: true
  cfg.include IgnorefileHelpers, fakefs: true
end
