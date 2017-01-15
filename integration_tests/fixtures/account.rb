module Fixtures

  module Account
    extend self
	
    @user_email = ENV['EMAIL']
    
    # Sign Up

    def valid_data_sign_up
      [ 
        "#{SecureRandom.uuid}@bar.com", 
        '1q2w3e4r1' 
      ]
    end

    def user_email_sign_up
      [ 
        "#{@user_email}", 
        '1q2w3e4r1' 
      ]
    end

    def invalid_data_sign_up
      [ 
        '', 
        '123' 
      ]
    end


    # Activation

    def valid_data_activation(confirmation_token)
      {
        confirmation_token: confirmation_token
      }
    end

    def invalid_body_activation(_confirmation_token)
      {
        confirmation_token: 'whatever'
      }
    end

    def invalid_key_activation(confirmation_token)
      {
        conf_token: confirmation_token
      }
    end


    # Edit Email, Forgot Password, Resend Activation

    def valid_data_email(email_address)
      {
        email_address: email_address
      }
    end

    def invalid_body_email(email_address)
      {
        email_address: email_address + '@'
      }
    end

    def invalid_key_email(email_address)
      {
        emailaddress: email_address
      }
    end

    
    # Reset Password

    def valid_data_reset_password(*params)
      {
        password: params[0], 
        reset_password_token: params[1]
      }
    end

    def incorrect_key_password(*params)
      {
        passwword: params[0], 
        reset_password_token: params[1]
      }
    end

  end

end
