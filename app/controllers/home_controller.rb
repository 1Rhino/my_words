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

  def search
    param_search = params["word"].downcase.squish
    words = Word.where("word like ? or translation like ?","%#{param_search}%","%#{param_search}%").limit(10)
    words = words.map{ |word| { "value" => word.word, "data" => word.translation } }
    return render json: words
  end

  private

  def word_params
    params.require(:word).permit!
  end

end
