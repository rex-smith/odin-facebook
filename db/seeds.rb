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
  Invitation.destroy_all
  Friendship.destroy_all
  Like.destroy_all
  Post.destroy_all
  Comment.destroy_all
  User.destroy_all

  # CREATING USERS AND POSTS

  10.times do |index|
    name = "#{Faker::Name.name}"
    email = "#{Faker::Internet.email}"
    password = ENV['SEED_USER_PASSWORD'] # Gives access to each user
    birthdate = "#{Faker::Date.between(from: 40.years.ago, to: 10.years.ago)}"
    gender = "#{Faker::Gender.binary_type}"
    address = "#{Faker::Address.full_address}"
    phonenumber = "#{Faker::PhoneNumber.cell_phone}"
    date = Faker::Date.between(from: 30.days.ago, to: Date.today)

    user = User.create!(
      name: name,
      email: email,
      password: password,
      birthdate: birthdate,
      gender: gender,
      address: address,
      phonenumber: phonenumber,
      created_at: date,
      updated_at: date
    )

    @users << user

    5.times do |index|
      title = "#{Faker::Games::Fallout.quote}".capitalize
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


