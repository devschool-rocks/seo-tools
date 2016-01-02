module Grading
  extend self

  def letter_grade(val)
    return "A"  if (90..100).include?(val)
    return "B"  if (80..89).include?(val)
    return "C"  if (70..79).include?(val)
    return "D"  if (60..69).include?(val)
    "F"
  end
end
