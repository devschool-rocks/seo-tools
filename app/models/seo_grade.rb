class SeoGrade < ActiveRecord::Base
  has_many :seo_grade_points
  has_many :grade_points, through: :seo_grade_points,
            dependent: :destroy

  belongs_to :keyword

  scope :recent_first, -> {
    order(created_at: :desc)
  }

  scope :latest, ->{
    with_keywords.
      select("DISTINCT ON(keywords.value) seo_grades.*").
      order("keywords.value, seo_grades.url, seo_grades.created_at DESC")
  }

  scope :with_keywords, -> {
    joins("LEFT JOIN keywords ON keywords.id = keyword_id")
  }

  scope :previous_day, -> {
    latest.
      where("seo_grades.created_at <= ?", 1.day.ago).limit(1)
  }

  def keyword=(val)
    write_attribute :keyword_id, Keyword.find_or_create_by(value: val.strip).id
  end

  def letter_grade
    Grading.letter_grade(grade)
  end

  def grade
    seo_grade_points.sum(:score)/seo_grade_points.count
  end

  def change
    previous = SeoGrade.where(keyword: keyword,
                              url: url).previous_day[0]
    return "-" if previous.nil?
    prev = previous.grade
    chg = prev.to_i - grade.to_i
    mod = chg > -1 ? (chg > 0 ? "+" : "") : "-"
    "#{mod}#{chg}"
  end

end
