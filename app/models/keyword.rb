class Keyword < ActiveRecord::Base
  has_many :rankings, dependent: :destroy
  has_many :seo_grades, dependent: :destroy
end
