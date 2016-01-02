class SeoGradePoint < ActiveRecord::Base
  belongs_to :seo_grade
  belongs_to :grade_point

  scope :recent_first, -> {
    order(created_at: :desc)
  }

  scope :latest, ->{
    with_seo_grades.
      order("seo_grade_points.created_at DESC")
  }

  scope :previous_day, -> {
    with_seo_grades.
      latest.
      where("seo_grades.created_at <= ?", 1.day.ago).limit(1)
  }

  scope :with_seo_grades, -> {
    joins("LEFT JOIN seo_grades ON seo_grades.id = seo_grade_points.seo_grade_id")
  }

  def change
    previous = SeoGradePoint.where(seo_grade: seo_grade,
                                   grade_point: grade_point).previous_day[0]
    return "-" if previous.nil?
    prev = previous.position
    chg = prev.to_i - position.to_i
    mod = chg > -1 ? (chg > 0 ? "+" : "") : "-"
    "#{mod}#{chg}"
  end
end
