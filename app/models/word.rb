#encoding: utf-8
class Word < ActiveRecord::Base
  has_many :translations, dependent: :destroy

  validates :word, presence: true, uniqueness: {case_sensitive: false}
end
