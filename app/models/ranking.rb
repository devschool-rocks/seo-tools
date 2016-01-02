class Ranking < ActiveRecord::Base
  belongs_to :keyword

  scope :recent_first, -> {
    order(created_at: :desc)
  }

  scope :latest, ->{
    with_keywords.
      select("DISTINCT ON(keywords.value, rankings.position) rankings.*").
      order("keywords.value, rankings.position")
  }

  scope :previous_day, -> {
    latest.
      where("rankings.created_at <= ?", 1.day.ago).limit(1)
  }

  scope :with_keywords, -> {
    joins("LEFT JOIN keywords ON keywords.id = keyword_id")
  }

  def match=(val)
    self.keyword = Keyword.find_by(value: val)
  end

  def change
    previous = Ranking.where(keyword: keyword, url: url).previous_day[0]
    return "-" if previous.nil?
    prev = previous.position
    chg = prev.to_i - position.to_i
    mod = chg > -1 ? (chg > 0 ? "+" : "") : "-"
    "#{mod}#{chg}"
  end

end
