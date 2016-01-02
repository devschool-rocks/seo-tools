require 'google-search'

module RankingService
  extend self

  def call(domains, keywords)
    keywords.flat_map {|kw| rank(domains, kw) }.compact
  end

private

  def rank(domains, keyword)
    engines.flat_map do |e|
      "#{e}_engine".classify.constantize.rank(domains, keyword)
    end
  end

  def engines
    %i[google]
  end
end
