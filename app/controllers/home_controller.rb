require 'will_paginate/array'

class HomeController < ApplicationController
  include HomeHelper

  def index
    @new_words = Word.new_words(15) # maximum = 15 words
    @popular_words = Word.popular_words(15) # maximum = 15 words
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
    @list_words = Word.all_words(params)
    @total = @list_words.count
  end

  def like_words
    @list_words = Word.like_words(params)
    @total = @list_words.count
    render 'all_words'
  end

  def random_words
    @list_words = Word.random_words
    render layout: 'random_words'
  end

  def get_words
    all_words =  Word.order("view_counter DESC").map{ |word| { "value" => word.word, "data" => word.translation } }
    return render json: all_words
  end

  def toogle_like
    result = Word.toogle_like(params[:id])
    return render text: result
  end

  def get_all_data_json
    return render json: Word.all.to_json
  end

  private

  def word_params
    params.require(:word).permit!
  end

end
