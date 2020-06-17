# frozen_string_literal: true

require_relative 'status_checker'

puts 'enter path to file (or or press enter to use test file)'
path = gets.chomp
path = 'websites_to_check.csv' if path.empty?
pp StatusChecker.new(path).to_h
