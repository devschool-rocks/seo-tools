class RankingsController < ApplicationController
  def index
    @ranking = Ranking.latest
  end

end
