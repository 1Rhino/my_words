class HomeController < ApplicationController
  def index
  end

  def new
    @word = params["word"]
  end
end
