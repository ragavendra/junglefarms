module Fixtures
  module AdditionalDocument
    extend self

    def valid_data(overrides = {})
      { upload: File.new(File.dirname(__FILE__) + '/photo.jpg') }.merge(overrides)
    end

    def invalid_data
      valid_data(upload: nil)
    end
    
  end
end
