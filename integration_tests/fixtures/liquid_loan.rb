module Fixtures

  module LiquidLoan
    extend self

    def valid_data(overrides = {})
      {
        credit_application_id: 1,
        amount: 100.0,
        term: 4,
        repayment_frequency: "biweekly",
        loan_protection: false,
        initial_payment_date: "2015-17-03"
      }.merge(overrides)
    end
  end

end
