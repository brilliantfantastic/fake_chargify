class String
  def last(n)
    self.chars.to_a.last(n).to_s
  end
end