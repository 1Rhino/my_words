#encoding: utf-8
class Word < ActiveRecord::Base

  validates :word, presence: true, uniqueness: {case_sensitive: false}
  validates :translation, presence: true
end
