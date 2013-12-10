# encoding: utf-8
require 'csv'
namespace :import  do
  desc "Import words data to DB"
  task :data_json => :environment do

    puts "Delete all old data"
    Word.connection.execute("delete from words");

    puts "Import new data"
    all_data = JSON.parse(File.read(Rails.root.to_s + "/db/all_words.json"))
    all_data.each do |word|
      new_word = Word.new
      new_word.id = word["id"]
      new_word.word = word["word"]
      new_word.translation = word["translation"]
      new_word.view_counter = word["view_counter"]
      new_word.created_at = word["created_at"]
      new_word.updated_at = word["updated_at"]
      new_word.like = word["like"]
      new_word.save
    end


  end
end

