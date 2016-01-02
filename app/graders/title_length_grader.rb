module TitleLengthGrader
  extend self

  def call(title)
    grade(title)
  end

private

  def grade(title)
    l = title.length
    return 100 if (55..58).include?(l)
    return 90  if (51..54).include?(l)
    0
  end
end
