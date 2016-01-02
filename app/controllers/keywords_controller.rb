class KeywordsController < ApplicationController
  def index
    @keywords = Keyword.all
  end

  def create
    existing = Keyword.all.map(&:value)
    to_add   = params[:keywords].
                 split("\n").
                 map(&:strip).uniq
    to_add.each do |kw|
      next if existing.include?(kw.strip)
      Keyword.create value: kw.strip
    end
    redirect_to keywords_path
  end

  def destroy
    keyword = Keyword.find(params[:id])
    keyword.destroy
    redirect_to keywords_path
  end

end
