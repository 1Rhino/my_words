#encoding: utf-8
class Word < ActiveRecord::Base

  validates :word, presence: true, uniqueness: {case_sensitive: false}
  validates :translation, presence: true

  def self.create_data(param_word)
    word = Word.new(param_word)
    word.word = word.word.squish.downcase
    word.translation = word.translation.squish.downcase
    return nil unless word.valid?
    word.save
    return {"value" =>  word.word, "data" => word.translation}
  end

  def self.search_word(params)
    param_search = params["word"].squish
    param_search_downcase = params["word"].squish.downcase
    words = Word.where("word like ? OR word like ?","%#{param_search}%", "%#{param_search_downcase}%").order("view_counter DESC").limit(10)
    words = words.map{ |word| { "value" => word.word, "data" => word.translation } }
    return words
  end

  def self.get_detail_word(params)
    param_search = params["word"].squish
    param_search_downcase = params["word"].squish.downcase
    word = Word.where("word = ? OR word = ?", param_search, param_search_downcase).first
    if word.blank?
      return nil
    else
      begin
        word.view_counter = word.view_counter + 1
        word.save
      rescue
      end
      return { "value" => word.word, "data" => word.translation, "id" => word.id, "like" => word.like }
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

  def self.like_words(params)
    Word.where(like: true).order("view_counter desc, id desc").paginate(per_page: 30, page: params["page"])
  end

  def self.all_words(params)
    sort_by = "id"
    sort_by = 'view_counter' if !params['sort_by'].blank? && params['sort_by'] == 'popular'
    Word.order("#{sort_by} DESC").paginate(per_page: 30, page: params["page"])
  end

  def self.toogle_like(id_word)
    word = Word.where(id: id_word.to_i).first
    return "false" if word.blank?

    begin
      word.like = !word.like
      word.save
      return 'true'
    rescue
      return 'false'
    end
  end

end
