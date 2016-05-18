class SuggestionsController < ApplicationController
  skip_before_action :require_login, only: :index

  def index

  end

  def new
    @suggestions = Food.new
  end
  
end
