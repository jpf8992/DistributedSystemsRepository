#Taken from -   http://stackoverflow.com/questions/2730854/ruby-how-to-get-the-first-character-of-a-string

class String
  def initial
    self[0,4]	#refers to the instance of the class itself
  end
end