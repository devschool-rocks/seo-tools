class RankingsController < ApplicationController
  def index
    @ranking = Ranking.find_ranking_changes.latest
  end

end
