module Fixtures
  module ContactNumber
    extend self

    def valid_data(overrides = {})
      {
        contact_number: '6045573458',
        verification_method: 'sms'
      }.merge(overrides)
    end

    def voice_verification_method
      valid_data(verification_method: 'voice')
    end

    def invalid_contact_number
      valid_data(contact_number: '1')
    end

  end
end
