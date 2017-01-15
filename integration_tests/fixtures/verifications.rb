module Fixtures
  module Verifications
    extend self

    # Ca Contact Number
    def ca_contact_number_valid_data(credit_application_id, overides={})
      {
        "credit_application_id": credit_application_id,
        "verification_method": "sms"
      }.merge(overides)
    end

    def ca_contact_number_invalid_data(credit_application_id)
      ca_contact_number_valid_data(credit_application_id, {verification_method: 'not-supported'})
    end
    
    def ca_contact_number_invalid_key(_credit_application_id = nil)
      {
        "verf_method": "sms"
      }
    end

    def ca_put_contact_number_valid_data(credit_application_id, verification_pin)
      {
        "credit_application_id": credit_application_id,
        "resource_name": "ca_contact_number",
        "verification_pin": verification_pin
      }
    end

    def ca_put_contact_number_invalid_data(credit_application_id, verification_pin)
      {
        "credit_application_id": credit_application_id,
        "resource_namea": "ca_contact_number"
      }
    end

    def resource_valid_data(credit_application_id, resource_name)
      {
        "credit_application_id": credit_application_id,
        "resource_name": resource_name
      }
    end

    def resource_invalid_data(credit_application_id)
      {
        "credit_application_id": credit_application_id,
        "resource_name": 'whatever'
      }
    end

    def resource_invalid_key(credit_application_id)
      {
        "credit_application_id": credit_application_id,
        "resource_namea": 'whatever'
      }
    end
    
  end
end
