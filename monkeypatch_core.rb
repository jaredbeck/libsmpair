class String
  def strictly_decimal?
    match(/^\-?[0-9]+\.[0-9]+$/) and to_f != 0.0
  end
  
  def strictly_integer?
    match(/^\-?[0-9]+$/)
  end
end