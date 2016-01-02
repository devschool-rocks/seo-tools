module GoogleEngine
  extend self

  def rank(domains, keyword)
    find_rankings(domains, keyword)
  end

private

  def find_rankings(domains, keyword)
    search = Google::Search::Web.new do |search|
      search.query = keyword
      search.size = :large
    end
    search.flat_map do |item|
      item if domains.select do
        |uri| /#{uri}/ =~ item.uri
      end.any?
    end.compact.map do |item|
      { match: keyword, url: item.uri, position: item.index+1}
    end
  end

end
