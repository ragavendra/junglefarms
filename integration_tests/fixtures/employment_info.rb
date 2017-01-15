module Fixtures
  module EmploymentInfo
    extend self

    def valid_data(overrides = {})
      {
        "name": "Company Name",
        "address": "71 Stationview Pl",
        "suite": "",
        "city": "Bolton",
        "province": "Ontario",
        "postal_code": "L7E 1K9",
        "phone_number": "6041233456",
        "extension": "",
        "job_title": "Software Developer",
        "pay_frequency": "every_two_weeks"
      }.merge(overrides)
    end
    
    def invalid_data(overrides = {})
      {
        "name": nil,
        "address": "71 Stationview Pl",
        "suite": "",
        "city": "Bolton",
        "province": "Ontario",
        "postal_code": "L7E 1K9",
        "phone_number": "6041233456",
        "extension": "",
        "job_title": "Software Developer",
        "pay_frequency": "every_two_weeks"
      }.merge(overrides)
    end

    def put_valid_data(overrides = {})
      {
        "name": "Edited Company Name",
        "address": "71 Stationview Pl",
        "suite": "",
        "city": "Bolton",
        "province": "Ontario",
        "postal_code": "L7E 1K9",
        "phone_number": "6041233456",
        "extension": "",
        "job_title": "Software Developer",
        "pay_frequency": "every_two_weeks"
      }.merge(overrides)
    end

    def put_invalid_data(overrides = {})
      {
        "address": "71 Stationview Pl",
        "suite": "",
        "city": "Bolton",
        "province": "Ontario",
        "postal_code": "L7E 1K9",
        "phone_number": "6041233456",
        "extension": "",
        "job_title": "Software Developer",
        "pay_frequency": "every_two_weeks"
      }.merge(overrides)
    end
    
  end
end
