# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

@users = []

ActiveRecord::Base.transaction do
  Request.destroy_all
  Friendship.destroy_all
  Like.destroy_all
  Post.destroy_all
  Comment.destroy_all
  User.destroy_all

  # CREATING USERS AND POSTS

  10.times do |index|
    first_name = "#{Faker::Name.first_name}"
    last_name = "#{Faker::Name.last_name}"
    email = "#{Faker::Internet.email}"
    password = ENV['SEED_USER_PASSWORD'] # Gives access to each user
    birthdate = "#{Faker::Date.between(from: 40.years.ago, to: 10.years.ago)}"
    gender = "#{Faker::Gender.binary_type}"
    address = "#{Faker::Address.full_address}"
    phone_number = "#{Faker::PhoneNumber.cell_phone}"
    date = Faker::Date.between(from: 30.days.ago, to: Date.today)

    user = User.create!(
      first_name: first_name,
      last_name: last_name,
      email: email,
      password: password,
      birthdate: birthdate,
      gender: gender,
      address: address,
      phone_number: phone_number,
      created_at: date,
      updated_at: date
    )

    @users << user

    5.times do |index|
      title = "#{Faker::Fantasy::Tolkien.poem}".capitalize
      body = "#{Faker::GreekPhilosophers.quote}"
      date = Faker::Date.between(from: 30.days.ago, to: Date.today)
      Post.create!(
        title: title,
        body: body,
        created_at: date,
        updated_at: date,
        user: user
      )
    end
  end

  # CREATING FRIENDSHIPS AND REQUESTS

  User.all.each do |user|
    date = Faker::Date.between(from: 30.days.ago, to: Date.today)
    until user.friends.reload.size >= 4 do
      random_number = rand(user.not_friends_or_pending.size)
      friend = user.not_friends_or_pending[random_number]
      Friendship.create!(
        user: user,
        friend: friend,
        created_at: date,
        updated_at: date
      )
      Friendship.create!(
        user: friend,
        friend: user,
        created_at: date,
        updated_at: date
      )
    end
  end

  User.all.each do |user|
    until user.not_friends_or_pending.size <= 2 do
      date = Faker::Date.between(from: 30.days.ago, to: Date.today)
      random_number = rand(user.not_friends_or_pending.size)
      potential_friend = user.not_friends_or_pending[random_number]
      Request.create!(
        user: user,
        requested_friend: potential_friend,
        created_at: date,
        updated_at: date
      )
    end
  end

  # CREATING COMMENTS AND LIKES

  Post.all.each do |post|
    5.times do |index|
      user = @users[rand(@users.length)]
      date = Faker::Date.between(from: 30.days.ago, to: Date.today)
      body = "#{Faker::Books::Dune.quote}"
      Comment.create!(
        body: body,
        user: user,
        commentable: post,
        created_at: date,
        updated_at: date
      )
    end
  end

  Post.all.each do |post|
    rand(10).times do |index|
      user = @users[rand(@users.length)]
      date = Faker::Date.between(from: 30.days.ago, to: Date.today)
      Like.create!(
        user: user,
        likeable: post,
        created_at: date,
        updated_at: date
      )
    end
  end

  Comment.all.each do |comment|
    rand(10).times do |index|
      user = @users[rand(@users.length)]
      date = Faker::Date.between(from: 30.days.ago, to: Date.today)
      Like.create!(
        user: user,
        likeable: comment,
        created_at: date,
        updated_at: date
      )
    end
  end



end

@users.each do |user|
  user.ensure_avatar
end

