# Please ignore this file; it's just plumbing for the golf scoring
require 'pp'

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
    attr_reader :results, :hole_data, :options

    def initialize(options)
      @options = options
      @hole_data = {}
      @results = []
      @current_hole = nil

      if options[:debug]
        puts "Ruby: #{RUBY_VERSION}; Minitest: #{Minitest::VERSION}"
      end
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
      lines = File.readlines('golf.rb')

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

      pp hole_data: hole_data if options[:debug]

      puts
      hole_data.each do |hole, data|
        hole_body_lines = lines[data[:start_line]..data[:end_line]]
        hole_body_lines.shift # remove the 'def' line
        hole_body_lines.pop # remove the 'end' line
        hole_body_lines.reject! { |line| line =~ /\A\s*\z/ || line =~ (/\A\s*#/) }
        hole_body = hole_body_lines.join.strip #.squeeze(' ')
        if data[:incomplete]
          puts "Hole #{hole}: Not all tests are passing for this hole yet. Keep going!"
        else
          puts "Hole #{hole}: #{hole_body.each_char.count} characters"
          puts "Body: #{hole_body.inspect}\n\n" if options[:debug]
        end
      end
    end
  end
end
