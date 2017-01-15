## Integration Tests

Exising tests: (exist in integration\_tests/tests)  
**activate.rb  
edit\_email.rb  
fetch\_account.rb  
forgot\_password.rb  
login.rb  
resend\_activation.rb  
reset\_password.rb  
signup.rb  
create\_credit\_application.rb**

### Usage:

Each test has its own arguments:
_(these will be expanded as the tests increase)_

Example:  

No arguments:

```
> cd integration_test
> HOSTNAME=dockervm PORT=443 ruby tests/signup.rb
```

Arguments:

```
> cd integration_test
> HOSTNAME=dockervm PORT=443 ruby tests/login.rb username@foo.com pAssw0rd
```

If arguments are needed and not supplied, a message will show what is needed:

```
> HOSTNAME=dockervm PORT=443 ruby tests/login.rb
  Usage: ruby login.rb username password
```

The hostname used in the calls is defined in constants.rb; edit this to suit your purposes. In the near future we can think of a cleaner was to specify the hostname since it might differ for each environment.

### Fixtures:

Some of the tests have fixtures available. If you don't specify one, a valid fixture will be used as default.

| Integration Test  | Available Fixtures |
| ------------- | ------------- |
| activate  | **valid_data_activation**, invalid_body_activation, invalid_key_activation  |
| edit_email  | **valid_data_email**, invalid_body_email, invalid_key_email  |
| fetch_account  | - |
| forgot_password  | **valid_data_email**, invalid_body_email, invalid_key_email  |
| login  | -  |
| resend_activation  | **valid_data_email**, invalid_body_email, invalid_key_email  |
| reset_password  | **valid_data_reset_password**, incorrect_key_password  |
| signup  | -  |
| create_credit_application  | **valid_data**, missing_last_name, missing_postal_code  |

\** **bolded** fixtures are the default ones.

### Notes:
* You will need the Confirmation Token generated by the _sign_up_ in order to execute the _activate_ test.  This can be found by watching the logger service log or the member service logs.
* You will need to send a _forgot_password_ request in order to get the Reset Password Token for the _reset_password_ test.
* It helps to keep an eye on of the logger service log when running the integrations tests.

### Overriding individual containers

If running the integration tests scripts when running docker-compose, and you wish to run a service locally for debugging purposes you must first stop the running container. The example below details the steps involved to start the api_server locally.

Running the api_server locally with containers.

1. First stop the api_server, it will be a command similar to ```docker stop soa_apiserver_1```
2. Then run the following command to start the api_server locally. ```REDIS_HOST=dockervm MQ_HOST=dockervm LOCAL=1 rackup```
3. Perform your integration test. Note that HOSTNAME and PORT are different and bypass the haproxy container altogether. ```HOSTNAME=localhost PORT=9292 ruby tests/signup.rb valid_data_sign_up```