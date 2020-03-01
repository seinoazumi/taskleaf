FactoryBot.define do
  factory :task do
    name { 'テストを書く' }
    description { 'タスクのテストです' }
    user
  end
end
