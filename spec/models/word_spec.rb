require 'spec_helper'

describe Word do
  it "can be create data with word model" do
    FactoryGirl.create(:word)
    expect(Word.count).to be > 0
  end

  it "can be delete data with word model" do
    FactoryGirl.create(:word)
    expect(Word.count).to be > 0
    Word.destroy_all
    expect(Word.count).to eq 0
  end

  it "is invalid when create with null data" do
    expect(Word.new).not_to be_valid
  end

  it "is invalid when create data with null word" do
    expect(FactoryGirl.build(:word, word: '')).to have(1).errors_on(:word)
  end

  it "can not duppliate word" do
    FactoryGirl.create(:word)
    expect(FactoryGirl.build(:word)).to have(1).errors_on(:word)
  end

  it "has has_many relationship with translations" do
    relationship = Word.reflect_on_association(:translations)
    expect(relationship.macro).to eq :has_many
  end

  it "is valid when build data with associations" do
    word = FactoryGirl.build(:word)
    word.translations << FactoryGirl.build(:translation)
    expect(word).to be_valid
  end

  it "can create data with associations" do
    word = FactoryGirl.build(:word)
    word.translations << FactoryGirl.build(:translation)
    word.save
    expect(Word.last.translations.count).to eq 1
  end

  it "can be delete word and remove its translations" do
    # create 2 sample data
    FactoryGirl.create(:word, word: "First")
    FactoryGirl.create(:word, word: "Second")
    # create data with associations
    word = FactoryGirl.build(:word, word: "Third")
    word.translations << FactoryGirl.build(:translation)
    word.save
    # check data with associations
    expect(Word.last.translations.count).to eq 1
    # delete data with associations and check again
    Word.last.destroy
    expect(Word.last.translations.count).to eq 0
  end

end
