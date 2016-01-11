require 'ranking_service'

class SerpsController < ApplicationController
  respond_to :json, only: :update

  def index
    if Ranking.current_day && Ranking.previous_day.empty? == false
      @rankings = Ranking.find_ranking_changes
      else
      @rankings = Ranking.latest
    end
  end
end
