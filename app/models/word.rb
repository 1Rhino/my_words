#encoding: utf-8
class Word < ActiveRecord::Base

  validates :word, presence: true, uniqueness: {case_sensitive: false}
  validates :translation, presence: true

  def self.create_data(param_word)
    word = Word.new(param_word)
    word.word = word.word.squish.downcase
    word.translation = word.translation.squish.downcase
    return "false" unless word.valid?
    word.save
    return "true"
  end

  def self.search_word(params)
    param_search = params["word"].squish.downcase
    words = Word.where("word like ?","%#{param_search}%").order("view_counter DESC").limit(10)
    words = words.map{ |word| { "value" => word.word, "data" => word.translation } }
    return words
  end

  def self.get_detail_word(params)
    param_search = params["word"].squish
    word = Word.where(word: param_search).first
    if word.blank?
      return nil
    else
      begin
        word.view_counter = word.view_counter + 1
        word.save
      rescue
      end
      return { "value" => word.word, "data" => word.translation, "id" => word.id }
    end
  end

  def self.update_word(param_word)
    word = Word.where(id: param_word["id"].to_i).first
    return "false" if word.blank?

    word.word = param_word['word'].squish.downcase
    word.translation = param_word['translation'].squish.downcase

    return "false" unless word.valid?
    begin
      word.save
    rescue
    end
    return "true"
  end

  def self.new_words(maximum_words)
    Word.order("id desc").limit(maximum_words)
  end

  def self.popular_words(maximum_words)
    Word.order("view_counter desc, id desc").limit(maximum_words)
  end

end
