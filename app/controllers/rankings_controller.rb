class RankingsController < ApplicationController
  def index
    @rankings = Ranking.find_ranking_changes
  end

end
