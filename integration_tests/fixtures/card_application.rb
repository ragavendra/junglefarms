module Fixtures

  module CardApplication
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
        "postal_code": "L7E 1K9"
      }.merge(overrides)
    end

    def missing_last_name
      valid_data("last_name": '')
    end

    def missing_postal_code
      valid_data("postal_code": '')
    end

    def invalid_dob_ab
      valid_data('birth_date': '2002-09-28', 'province': 'Alberta')
    end

    def bad_dob
      valid_data('birth_date': '2002-09-xx')
    end

    def bad_char_in_name
      valid_data('first_name': 'foo$')
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
        "postal_code": nil
      }
    end
  end
  
end