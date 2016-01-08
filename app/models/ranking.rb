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
    joins("LEFT JOIN keywords ON keywords.id = keyword_id" )
  }

  def self.find_ranking_changes
    query = <<-SQL
    select distinct rankings_info.keyword_id,
    rankings_info.url,
    latest_rankings.position as "position",
    max(earliest_rankings.position - latest_rankings.position) as "change"
    from
    (
      select
      keyword_id,
      url,
      min(created_at) as min_created_date,
      max(created_at) as max_created_date
      from rankings
      group by keyword_id, url
    )
      as rankings_info
        inner join rankings as earliest_rankings on
          earliest_rankings.keyword_id = rankings_info.keyword_id and
          earliest_rankings.created_at::date = current_date - 2
        inner join rankings as latest_rankings on
          latest_rankings.keyword_id = rankings_info.keyword_id
          where latest_rankings.created_at::date = current_date -1
          group by earliest_rankings.keyword_id, latest_rankings.keyword_id,
          rankings_info.keyword_id, earliest_rankings.position, latest_rankings.position, rankings_info.url
    SQL

    self.find_by_sql(query)
  end

  def match=(val)
    self.keyword = Keyword.find_by(value: val)
  end

  def change
    previous = Ranking.where(keyword: keyword, url: url).previous_day[0]
    return "-" if previous.nil?
    prev = previous.position
    chg = prev.to_i - position.to_i
    mod = chg > -1 ? (chg > 0 ? "+" : "") : ""
    "#{mod}#{chg}"
  end
end
