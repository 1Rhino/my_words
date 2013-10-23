class HomeController < ApplicationController
  def index
  end

  def new
    @word = params["word"]
  end

  def create
    word = Word.new(word_params)
    return render text: "false", layout: false unless word.valid?

    word.save
    return render text: "true", layout: false
  end

  private

  def word_params
    params.require(:word).permit!
  end

end
