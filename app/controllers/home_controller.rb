require 'will_paginate/array'

class HomeController < ApplicationController
  include HomeHelper

  def index
  end

  def create
    # function create_data return "true" or "false"
    created_data = Word.create_data(word_params)
    return render json: created_data
  end

  def search
    return render json: Word.search_word(params)
  end

  def get_detail
    word = Word.get_detail_word(params)
    return render nothing: true if word.blank?
    return render json: word
  end

  def update
    updated_word = Word.update_word(word_params)
    return render text: updated_word
  end

  def new_words
    new_words = Word.new_words(15) # maximum = 15 words
    return render text: render_words_list(new_words)
  end

  def popular_words
    popular_words = Word.popular_words(15) # maximum = 15 words
    return render text: render_words_list(popular_words)
  end

  def all_words
    sort_by = "id"
    sort_by = 'view_counter' if !params['sort_by'].blank? && params['sort_by'] == 'popular'
    @all_words = Word.order("#{sort_by} DESC").paginate(per_page: 30, page: params["page"])
    @total = @all_words.count
  end

 def get_words
  all_words =  Word.order("view_counter DESC").map{ |word| { "value" => word.word, "data" => word.translation } }
  return render json: all_words
 end
  private

  def word_params
    params.require(:word).permit!
  end

end
