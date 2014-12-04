$:.unshift(File.join(File.dirname(__FILE__), "..", "..", "libraries"))

RSpec.configure do |config|
  config.formatter = :documentation
end
