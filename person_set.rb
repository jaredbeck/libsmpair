require 'CSV'
require './person'

class PersonSet
  include Enumerable

  def self.read_csv(filepath)
    ps = PersonSet.new

    begin
      c = CSV.open filepath, :headers => true 
    rescue
      puts "Unable to open file: " + $!.to_s
      exit
    end

    c.each_with_index do |r,i|
      begin
        ps.push Person.new r['name'], r['rating']
      rescue
        puts "Invalid player record on line #{i+2}: " + $!.to_s
        exit
      end
    end
    
    return ps
  end

  def each() @people.each { |p| yield p } end
  def initialize() @people = [] end
  def push(p) @people.push p end
  def size() @people.length end
end
