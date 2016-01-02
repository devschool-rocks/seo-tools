require 'ranking_service'

class SerpsController < ApplicationController
  respond_to :json, only: :update

  def index
    @rankings = Ranking.latest
  end
end
