#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'byebug'
require 'json'
require 'logger'

class Test
  attr_reader :start_time
  attr_reader :end_time
  attr_reader :logger
  attr_reader :test_name

  def initialize(test_name, logger_level = Logger::WARN)
    @test_name = test_name
    @logger = Logger.new(STDOUT)
    @logger.progname = @test_name
    @logger.level = logger_level
  end

  def start
    @start_time = Time.now
  end

  def stop
    @end_time = Time.now
  end

  def elapsed_time
    @end_time - @start_time
  end
  
  def url
    "http://#{HOSTNAME}:#{PORT}"
  end

end
