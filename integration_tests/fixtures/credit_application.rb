module Fixtures

  module CreditApplication
    extend self

    def valid_data(overrides = {})
      {
        "member_id": 24,
        "first_name": "Plane",
        "last_name": "Testpal",
        "birth_date": "1981-11-11",
        "address": "71 Stationview Pl",
        "suite": "",
        "city": "Bolton",
        "province": "Ontario",
        "postal_code": "L7E 1K9",
        "residential_status": "Rent",
        "monthly_costs": 1500,
        "annual_income": 65270,
        "employment_type": "Employed",
        "employment_length": 54,
        "requested_amount": 2500,
        "loan_purpose": "Debt Consolidation",
        "credit_check_opt_in": true
      }.merge(overrides)
    end

    def missing_last_name
      valid_data("last_name": '')
    end

    def missing_postal_code
      valid_data("postal_code": '')
    end

    def missing_credit_check_opt_in
      valid_data("credit_check_opt_in": nil)
    end

    def invalid_dob_ab
      valid_data('birth_date': '2002-09-28', 'province': 'Alberta')
    end

    def bad_dob
      valid_data('birth_date': '2002-09-xx')
    end

    def bad_employment_type
      valid_data('employment_type': 'foo')
    end

    def bad_type_emp_length
      valid_data('employment_length': 'foo')
    end

    def bad_char_in_name
      valid_data('first_name': 'foo$')
    end

    def requested_amount_too_low
      valid_data('requested_amount': 2000)
    end

    def requested_amount_too_high
      valid_data('requested_amount': 36000)
    end

    def empty_data
      {
        "member_id": nil,
        "first_name": nil,
        "last_name": nil,
        "birth_date": nil,
        "address": nil,
        "city": nil,
        "province": nil,
        "postal_code": nil,
        "residential_status": nil,
        "monthly_costs": nil,
        "annual_income": nil,
        "employment_type": nil,
        "employment_length": nil,
        "requested_amount": nil,
        "loan_purpose": nil,
        "credit_check_opt_in": nil
      }
    end
  end
  
end