require 'CSV'
require './person'

class PersonSet
  include Enumerable

  def each() @people.each { |p| yield p } end
  def initialize() @people = [] end

  def read_csv(f)
    begin
      c = CSV.open f, :headers => true 
    rescue
      puts "Unable to open file: " + $!.to_s
      exit
    end

    c.each_with_index do |r,i|
      begin
        @people.push Person.new r['name'], r['rating']
      rescue
        puts "Invalid player record on line #{i+2}: " + $!.to_s
        exit
      end
    end
  end

  def size() @people.length end
end
