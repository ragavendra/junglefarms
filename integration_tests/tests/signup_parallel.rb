require 'parallel'

require_relative '../objects/account'
require_relative './signup'

over_all_test = Test.new('overall')
over_all_test.logger.level = Logger::DEBUG
over_all_test.start

Parallel.map(1..500, :in_processes => 10) do |test_id|
  test_name = "signup-#{test_id}"

  over_all_test.logger.debug "Starting #{test_name}"

  test_run = Test.new(test_name)
  test_run.start

  # run test
  Tests::Signup.run(test_run)

  test_run.stop
  test_run.logger.debug '==============================='
  test_run.logger.debug "Elapsed Time: #{test_run.elapsed_time} s\n"

  over_all_test.logger.debug "Completed #{test_name}"
end

over_all_test.stop
over_all_test.logger.debug '==============================='
over_all_test.logger.debug "(overall) Elapsed Time: #{over_all_test.elapsed_time} s\n"