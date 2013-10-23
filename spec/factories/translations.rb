# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :translation do
    translation "Tieng Anh"
    word_id 1
    like_counter 10
  end
end
