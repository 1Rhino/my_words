# encoding: utf-8
require 'csv'
namespace :import  do
  desc "Import words data to DB"
  task :words => :environment do

    Word.connection.execute("UPDATE SQLITE_SEQUENCE SET seq = 1")

    puts "Import words data"
    CSV.foreach(Rails.root.to_s+"/db/vocaburary.csv") do |row|
      word = Word.new
      word.word = row[2]
      word.translation = row[3]
      if word.valid?
        word.save
        puts "Imported:" + word.word
      end
    end

  end
end
