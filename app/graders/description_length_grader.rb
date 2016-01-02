module DescriptionLengthGrader
  extend self

  def call(title)
    grade(title)
  end

private

  def grade(title)
    l = title.strip.length
    return 100 if (150..164).include?(l)
    return 90  if (110..149).include?(l)
    0
  end
end
