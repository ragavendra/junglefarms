module Fixtures
  module FundingInfo
    extend self
    
    def valid_data(overrides = {})
      {
        "bank_name": "RBC",
        "bank_number": "003",
        "transit_number": "12345",
        "account_number": "1"
      }.merge(overrides)
    end

    def invalid_bank_number
      valid_data("bank_number": "0")
    end

    def cibc_bank
      valid_data("bank_name": "CIBC")
    end
    
  end
end
