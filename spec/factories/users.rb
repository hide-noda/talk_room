FactoryBot.define do
  factory :user do
    family_name           {Gimei.last.kanji}
    last_name             {Gimei.first.kanji}
    family_name_kana      {Gimei.last.katakana}
    last_name_kana        {Gimei.first.katakana}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 8)}
    password_confirmation {password}
  end
end