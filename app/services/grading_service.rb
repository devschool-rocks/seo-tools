require 'nokogiri'

module GradingService
  extend self

  def call(url, keyword)
    grade(url, keyword)
  end

private

  def grade(url, keyword)
    html = open(url).read
    title = match_title(html)
    meta_description = match_description(html)
    body = match_body(html)

    title_kwd  = TitleContainsKeywordGrader.(title, keyword)
    title_alng = TitleLengthGrader.(title)
    title_keys = KeywordStuffingGrader.(title, keyword)

    desc_kwd   = DescriptionContainsKeywordGrader.(meta_description, keyword)
    desc_alng  = DescriptionLengthGrader.(meta_description)

    body_keys  = BodyKeywordStuffingGrader.(body, keyword)

    totals = [
      title_kwd, title_alng, title_keys,
      desc_kwd, desc_alng, body_keys
    ]

    grand_total = totals.sum/totals.count

    {
      keyword_in_title:   title_kwd,
      title_length:       title_alng,
      title_stuffed:      title_keys,
      keyword_in_description:desc_kwd,
      description_length: desc_alng,
      body_stuffed:       body_keys,
    }.merge(total: grand_total,
            grade: Grading.letter_grade(grand_total))
  end


  def match_title(html)
    doc(html).xpath("//title").text
  end

  def match_description(html)
    doc(html).xpath("//meta[@name='description']/@content").text
  end

  def match_body(html)
    doc(html).xpath("//body").text
  end

  def doc(html)
    Nokogiri::HTML(html)
  end
end
