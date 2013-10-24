class HomeController < ApplicationController
  def index
  end

  def create
    word = Word.new(word_params)
    word.word = word.word.downcase.squish
    word.translation = word.translation.downcase.squish
    return render text: "false", layout: false unless word.valid?

    word.save
    return render text: "true", layout: false
  end

  def search
    param_search = params["word"].downcase.squish
    words = Word.where("word like ?","%#{param_search}%").order("view_counter DESC").limit(10)
      words = words.map{ |word| { "value" => word.word, "data" => word.translation } }
      return render json: words
  end

  def get_detail
    param_search = params["word"].squish
    word = Word.where(word: param_search).first
    if word.blank?
      return render nothing: true
    else
      begin
        word.view_counter = word.view_counter + 1
        word.save
      rescue
      end
      return render json: { "value" => word.word, "data" => word.translation, "id" => word.id }
    end
  end

  def update
    params = word_params
    word = Word.where(id: params["id"].to_i).first
    if word.blank?
      return render text: "false"
    else
      word.word = params['word'].downcase.squish
      word.translation = params['translation'].downcase.squish
      if word.valid?
        begin
          word.save
        rescue
        end
      else
        return render text: "false"
      end
      return render text: "true"
    end
  end

  private

  def word_params
    params.require(:word).permit!
  end

end
