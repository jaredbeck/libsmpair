class MWM
  def self.matching(edges)
    stdin, stdout, stderr = Open3.popen3('python lib/mwm/mwm.py')
    edges.each{|e| stdin.puts(e)}
    stdin.close
    return read_stream_as_array(stdout).map{|line| parse_mwm_line(line)}
  end
  
  def self.parse_mwm_line(l)
    l.chomp.split(' ').map{|x| x.to_i}
  end
  
  def self.read_stream_as_array(stream)
    a = []
    stream.each_line{|line| a << line}
    return a
  end
end
