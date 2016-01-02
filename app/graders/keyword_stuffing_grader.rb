module KeywordStuffingGrader
  extend self

  def call(text, keyword)
    grade(text, keyword)
  end

private

  def grade(text, keyword)
    uniq = unique_words(text)
    res = text.scan(/#{keyword}/)
    return 100 if res.count.to_f / uniq.count.to_f < 0.03
    return 80  if res.count.to_f / uniq.count.to_f < 0.02
    0
  end

  def unique_words(text)
    text.split(" ").uniq
  end
end

