# encoding: utf-8
namespace :export_json  do
  desc "Export data from sqlite to file json"
  task :export => :environment do

    all_words = Word.all.to_json
    File.open(Rails.root.to_s + "/db/all_words.json", 'w') {|f| f.write(all_words) }
    File.open(Rails.root.to_s + "/public/all_words.json", 'w') {|f| f.write(all_words) }

  end
end

