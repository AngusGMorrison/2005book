# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Mod.create(name: "GitPushGitPaid")

puts "#{Mod.all.length} mods created"

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
            photo_url: "www.webaddress.com"
)

User.create(name: "Eduardo Saverin",
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
            photo_url: "www.webaddress.com"
)

User.create(name: "Dustin Moscovitz",
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
            photo_url: "www.webaddress.com"
)

puts "#{User.all.length} users created"

Group.create(name: "DnD", description: "We play DnD every Wednesday", admin_id: User.first.id)
Group.create(name: "Dog Lovers", description: "Who doesn't love dogs?!", admin_id: User.first.id)

puts "#{Group.all.length} groups created"

Friendship.create(status: "Accepted", user_id: User.first.id, friend_id: User.second.id)
Friendship.create(status: "Accepted", user_id: User.first.id, friend_id: User.third.id)

puts "#{Friendship.all.length} friendships created"

GroupUser.create(group_id: Group.first.id, user_id: User.first.id)
GroupUser.create(group_id: Group.second.id, user_id: User.first.id)
GroupUser.create(group_id: Group.first.id, user_id: User.second.id)
GroupUser.create(group_id: Group.second.id, user_id: User.second.id)