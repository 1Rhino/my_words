require 'spec_helper'

describe Translation do
  it "can be create data with translation model" do
    FactoryGirl.create(:translation)
    expect(Translation.count).to be > 0
  end

  it "can be delete data with translation model" do
    FactoryGirl.create(:translation)
    expect(Translation.count).to be > 0
    Translation.destroy_all
    expect(Translation.count).to eq 0
  end

  it "is invalid when create with null data" do
    expect(Translation.new).not_to be_valid
  end

  it "is invalid when create data with null translation" do
    expect(FactoryGirl.build(:translation, translation: '')).to have(1).errors_on(:translation)
  end

  it "is valid when create data with null words_id" do
    expect(FactoryGirl.build(:translation, words_id: 1)).to be_valid
  end

  it "has belongs_to relationship with word" do
    relationship = Translation.reflect_on_association(:word)
    expect(relationship.macro).to eq :belongs_to
  end
end
