module TitleContainsKeywordGrader
  extend self

  def call(title, keyword)
    grade(title, keyword)
  end

private

  def grade(title, keyword)
    pos = title.downcase.index(keyword).to_i
    return 100 if pos == 0
    return 80  if pos > 0
    0
  end
end

