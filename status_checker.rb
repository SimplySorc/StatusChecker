# frozen_string_literal: true

require 'csv'
require 'json'
require 'net/http'


class StatusChecker
  def initialize(file_path)
    @results = []
    CSV.foreach(file_path, headers: :first_row) do |row|
      url = row.fetch('URL')
      @results << { name: url, status: get_site_status(url) }
    end
  end

  def to_json(*_args)
    @results.to_json
  end

  def to_h
    @results
  end

  private

  def get_site_status(url)
    Net::HTTP.start(url, use_ssl: true) { |http| http.head('/').code }
  rescue StandardError => e
    e.message
  end
end
