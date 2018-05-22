FactoryGirl.define do
  factory :user do
    name "tomo"
    email "hogehoge@gmail.com"
    # sequence(:email) {|n|"hoge_#{n + 1}"}
    password "12345"
    password_confirmation "12345"
  end
end