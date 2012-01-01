require "open3"

# MWM defines an interface to Joris van Rantwijk's python implementation
# of Maximum Weighted Matching
# http://jorisvr.nl/maximummatching.html

class MWM

  # `matching` runs `mwm.py` in an external process and parses stdout
  # into an array of pairings.
  def self.matching(edges)
    pairings = nil

    # `popen3` will implicitly close the streams when the block exits.
    # We must explicitly close stdin, however, or else mwm.py would
    # listen forever!
    Open3.popen3('python lib/mwm/mwm.py') {|stdin, stdout, stderr|
      write_array_then_close_stream(edges, stdin)
      pairings = read_stream_as_array(stdout).map{|line| parse_mwm_line(line)}
    }
    return pairings
  end
  
  def self.parse_mwm_line(l)
    l.chomp.split(' ').map{|x| x.to_i}
  end
  
  def self.read_stream_as_array(stream)
    a = []
    stream.each_line{|line| a << line}
    return a
  end

  def self.write_array_then_close_stream(array, stream)
    array.each{|e| stream.puts(e)}
    stream.close
  end
end
