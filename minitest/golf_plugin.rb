# Please ignore this file; it's just plumbing for the golf scoring
require 'pp'
require 'net/http'
require 'json'

module Minitest
  def self.plugin_golf_options(opts, options)
    opts.on "--debug", "Print golf debug options" do
      options[:debug] = true
    end
  end

  def self.plugin_golf_init(options)
    self.reporter << GolfReporter.new(options)
  end

  class GolfReporter < AbstractReporter
    attr_reader :results, :hole_data, :options, :team_name

    def initialize(options)
      @options = options
      @hole_data = {}
      @results = []
      @current_hole = nil

      if options[:debug]
        puts "Ruby: #{RUBY_VERSION}; Minitest: #{Minitest::VERSION}"
      end

      lines = File.readlines('golf.rb')

      if File.exists?('.team-name')
        @team_name = File.read('.team-name')
      else
        print "\n\nWelcome to Ruby Golf!\n\nBefore we run the tests, pick a name for your team: "
        @team_name = gets.strip
        File.open('.team-name', 'w') { |f| f.write(@team_name) }
      end

      lines.each.with_index do |line, index|
        if line =~ /\A\s*# Hole (\d+)/
          @current_hole = $1
        elsif line =~ /\A\s*def hole/
          hole_data[@current_hole] ||= {}
          hole_data[@current_hole][:start_line] = index
        elsif line =~ /\A\s*end # Hole/
          hole_data[@current_hole][:end_line] = index
        end
      end

      hole_data.each do |hole, data|
        hole_body_lines = lines[data[:start_line]..data[:end_line]]
        hole_body_lines.shift # remove the 'def' line
        hole_body_lines.pop # remove the 'end' line
        hole_body_lines.reject! { |line| line =~ /\A\s*\z/ || line =~ (/\A\s*#/) }
        data[:body] = hole_body_lines.join.strip
      end

      pp hole_data: hole_data if options[:debug]
    end

    def record(result)
      self.results << result
      if result.failures.any?
        class_name = result.respond_to?(:klass) ? result.klass : result.class.name
        hole = class_name.match(/Hole(\d+)Test/)[1]
        hole_data[hole] ||= {}
        hole_data[hole][:incomplete] = true
      end
    end

    def report
      puts "\nScores for '#{@team_name}':\n"
      hole_data.each do |hole, data|
        if data[:incomplete]
          puts "Hole #{hole}: Not all tests are passing for this hole yet. Keep going!"
        else
          puts "Hole #{hole}: #{data[:body].chars.count} characters"
        end
      end

      print "Sending data to server... "; STDOUT.flush
      send_data
      puts " done."
    end

    def send_data
      uri = URI(ENV['SCORE_URL'] || 'http://golf-scores.herokuapp.com/scores')

      # Create client
      http = Net::HTTP.new(uri.host, uri.port)
      post_data = {
        "score[name]" => @team_name
      }
      hole_data.each do |hole, data|
        data.each do |key, value|
          post_data["score[holes][#{hole}][#{key}]"] = value
        end
      end
      body = URI.encode_www_form(post_data)

      # Create Request
      req =  Net::HTTP::Post.new(uri)
      # Add headers
      req.add_field "Content-Type", "application/x-www-form-urlencoded; charset=utf-8"
      # Set body
      req.body = body

      # Fetch Request
      res = http.request(req)
    rescue StandardError => e
      puts "HTTP Request failed (#{e.message})"
    end
  end
end
