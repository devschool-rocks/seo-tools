require 'grading_service'

class SeoGradesController < ApplicationController
  def index
    @seo_grades = SeoGrade.latest
  end

  def new
    @seo_grade = SeoGrade.new
  end

  def show
    @seo_grade = SeoGrade.find(params[:id])
  end

  def create
    result = GradingService.(params[:seo_grade][:url],
                            params[:seo_grade][:keyword])

    seo_grade = SeoGrade.create(seo_grade_params).tap do |grade|
      GradePoint.all.each do |gp|
        grade.seo_grade_points.create grade_point: gp,
          score: result[gp.label.parameterize.underscore.to_sym]
      end
      grade
    end

    redirect_to seo_grade
  end

  def destroy
    seo_grade = SeoGrade.find(params[:id])
    seo_grade.destroy
    redirect_to seo_grades_path
  end

private

  def seo_grade_params
    params.require(:seo_grade).permit(:url, :keyword)
  end
end
