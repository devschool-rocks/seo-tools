module DescriptionContainsKeywordGrader
  extend self

  def call(title, keyword)
    grade(title, keyword)
  end

private

  def grade(title, keyword)
    pos = title.downcase.index(keyword).to_i
    return 100  if pos > -1
    0
  end
end

