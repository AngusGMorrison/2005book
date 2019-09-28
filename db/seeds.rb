# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Mod.delete_all
User.delete_all
Group.delete_all
Friendship.delete_all
Message.delete_all
GroupUser.delete_all

require 'faker'

Mod.create(name: "GitPushGitPaid")
Mod.create(name: "2b||!2b")
Mod.create(name: "!false")

puts "#{Mod.all.length} mods created"

photo_urls = [
    "https://live.staticflickr.com/5252/5403292396_0804de9bcf_b.jpg", 
    "https://i.dailymail.co.uk/i/pix/2013/08/29/article-2405475-1B8389EE000005DC-718_634x550.jpg",
    "https://d2jqdfju7ec8o3.cloudfront.net/2019/21/j6g7dw/7tg8hq.snsg8c.im.lg.jpg",
    "https://live.staticflickr.com/5252/5403292396_0804de9bcf_b.jpg",
    "http://blackstarters.com/wp-content/uploads/2017/11/89125B66-A114-4B47-94D6-A0E9698C98E3-683x1024-683x1024.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2s8aTEVRQTYpB5s8ZcGZPrhQaHoF426lRlY-dv6SicP-LIN3O7Q",
    "https://i.pinimg.com/736x/bd/5d/2c/bd5d2cd4fcfb4199d2f2ab70ba7e08dd.jpg",
    "https://foreignpolicy.com/wp-content/uploads/2012/05/saverin6.jpg?w=624",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRw51ovpVulrI276Vx29nbtFAsZ2LjQPqwaKT7qEQwdFC0vzBC3-w",
    "https://media.workandmoney.com/23/52/2352bf5fa0534febb412b69b8e77c9e3.png",
    "https://laurelsprings.com/wp-content/uploads/2017/11/val-2-1032x1024.jpg"
]

50.times do 
    User.create(

        name: Faker::Name.unique.name,
        email: Faker::Internet.unique.email,
        password: "123456",
        mod_id: Mod.all.sample.id,
        sex: Faker::Gender.binary_type,
        studies: Faker::Lorem.sentence(word_count: 2),
        phone_number: Faker::PhoneNumber.phone_number ,
        screenname: Faker::Lorem.sentence(word_count: 1),
        looking_for: Faker::Lorem.sentence(word_count: 1),
        interested_in: Faker::Lorem.sentence(word_count: 2),
        relationship_status: Faker::Lorem.sentence(word_count: 2),
        political_views: Faker::Lorem.sentence(word_count: 1),
        interests: Faker::Lorem.sentence(word_count: 5),
        movies: Faker::Lorem.sentence(word_count: 3),
        music: Faker::Music.band,
        websites: Faker::Internet.url,
        about_me: Faker::Lorem.sentence(word_count: 10),
        photo_url: photo_urls.sample, 
        accepted_terms: true
    )
end

User.create(name: "Mark Zuckerberg",
            email: "mark@facebook.com",
            password_digest: nil,
            mod_id: 1,
            sex: "Male",
            studies: "Human behaviour",
            phone_number: "06545675346",
            screenname: "Zuckonit",
            looking_for: "Your data",
            interested_in: "World domination",
            relationship_status: "Married",
            political_views: "Zucker-centric",
            interests: "Testifying before the Senate",
            movies: "Anything but The Social Network",
            music: "The dial-up tone",
            websites: "www.thefacebook.com",
            about_me: "Bleep bloop",
            photo_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/MarkZuckerberg-crop.jpg/210px-MarkZuckerberg-crop.jpg"
)

puts "#{User.all.length} users created"

10.times do
    Group.create(name: Faker::Lorem.sentence(word_count: 2), description: Faker::Lorem.sentence(word_count: 10), admin_id: User.all.sample.id)
end

Group.create(name: "Dog Lovers", description: "Who doesn't love dogs?!", admin_id: User.all.sample.id)
Group.create(name: "DnD", description: "We play DnD every Wednesday", admin_id: User.all.sample.id)

puts "#{Group.all.length} groups created"

20.times do 
    Friendship.create(status: "Accepted", user_id: User.all.sample.id, friend_id: User.all.sample.id)
end

puts "#{Friendship.all.length} friendships created"

25.times do 
    GroupUser.create(group_id: Group.all.sample.id, user_id: User.all.sample.id)
end

puts "#{GroupUser.all.length} people joined groups"

100.times do 
    Message.create(sender_id: User.all.sample.id, receiver_id: User.all.sample.id, subject: Faker::Lorem.sentence(word_count: 2), content: Faker::Lorem.sentence(word_count: 15))
end

puts "#{Message.all.length} messages shared"


