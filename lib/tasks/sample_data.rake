namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Zhurin Vlad",
                 email: "vlad032@mail.ru",
                 password: "1q2w3e4r5t",
                 password_confirmation: "1q2w3e4r5t",
                         admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all.limit(6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
  end
end