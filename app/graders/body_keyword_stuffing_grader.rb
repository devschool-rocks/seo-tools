require 'nokogiri'

module BodyKeywordStuffingGrader
  extend self

  def call(html, keyword)
    grade(html, keyword)
  end

private

  def grade(html, keyword)
    uniq = unique_words(html)
    res = html.scan(/#{keyword}/)
    return 100 if res.count.to_f / uniq.count.to_f < 0.03
    return 80  if res.count.to_f / uniq.count.to_f < 0.02
    0
  end

  def unique_words(html)
    d = doc(html)
    d.css('script, link').
      each { |node| node.remove }
    d.css('body').text.squeeze(" \n").split(" ").uniq
  end

  def doc(html)
    Nokogiri::HTML(html)
  end

end

