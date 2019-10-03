require 'faker'

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

# Clear database
Mod.delete_all
User.delete_all
Group.delete_all
FriendRequest.delete_all
Friendship.delete_all
Message.delete_all
GroupUser.delete_all
Chain.delete_all


# Create mods
Mod.create(name: "GitPushGitPaid")
Mod.create(name: "2b||!2b")
Mod.create(name: "!false")

puts "#{Mod.all.length} mods created"


#Create looking_for_options
LookingForOption.create(name: "Friendship")
LookingForOption.create(name: "Dating")
LookingForOption.create(name: "A Relationship")
LookingForOption.create(name: "Random play")
LookingForOption.create(name: "Whatever I can get")

puts "#{LookingForOption.all.length} looking_for_options created"


#Create political views
PoliticalView.create(name: "Very Conservative")
PoliticalView.create(name: "Conservative")
PoliticalView.create(name: "Moderate")
PoliticalView.create(name: "Liberal")
PoliticalView.create(name: "Very Liberal")

puts "#{PoliticalView.all.length} political views created"


# Create users
50.times do 
    User.create(
        name: Faker::Name.name.gsub(/[^a-zA-Z\-\' ]/, ""),
        email: Faker::Internet.unique.email,
        birthday: Faker::Date.birthday(min_age: 18, max_age: 80),
        password: "123456",
        mod_id: Mod.all.sample.id,
        accepted_terms: true
    )

    Profile.create(
      user_id: User.last.id,
      sex: Faker::Gender.binary_type,
      studies: Faker::Lorem.sentence(word_count: 2),
      hometown: Faker::Address.city,
      phone_number: Faker::PhoneNumber.phone_number,
      screenname: Faker::Lorem.sentence(word_count: 1),
      interested_in: Faker::Lorem.sentence(word_count: 2),
      relationship_status: Faker::Lorem.sentence(word_count: 2),
      political_view_id: PoliticalView.all.sample,
      interests: Faker::Lorem.sentence(word_count: 5),
      books: Faker::Lorem.sentence(word_count: 4),
      movies: Faker::Lorem.sentence(word_count: 3),
      music: Faker::Music.band,
      websites: Faker::Internet.url,
      about_me: Faker::Lorem.sentence(word_count: 10),
      photo_url: photo_urls.sample
    )

    Profile.last.generate_slug
end

puts "#{User.all.length} users and #{Profile.all.length} profiles created"


# Create groups
10.times do
    Group.create(name: Faker::Lorem.sentence(word_count: 2), description: Faker::Lorem.sentence(word_count: 10), admin_id: User.all.sample.id)
end

Group.create(name: "Dog Lovers", description: "Who doesn't love dogs?!", admin_id: User.all.sample.id)
Group.create(name: "DnD", description: "We play DnD every Wednesday", admin_id: User.all.sample.id)

puts "#{Group.all.length} groups created"


# Create GroupUsers
25.times do 
  GroupUser.create(group_id: Group.all.sample.id, user_id: User.all.sample.id)
end

puts "#{GroupUser.all.length} people joined groups"


# Give everyone 10 friends
User.all.each do |user|
    5.times do  
      Friendship.find_or_create_by(user_1: user, user_2: User.all.sample)
    end
  
    5.times do 
      Friendship.find_or_create_by(user_1: User.all.sample, user_2: user)
    end 
end

puts "#{Friendship.all.length} friendships created"


# Create message chains
10.times do 
  Chain.create()
end

puts "#{Chain.all.length} chains started"

# Give each chain two users and some messages
Chain.all.each do |chain|
  u1 = User.all.sample
  u2 = u1.friends.sample

  5.times do 
    Message.create(chain_id: chain.id, sender_id: u1.id, receiver_id: u2.id, content: Faker::Lorem.sentence(word_count: 10))
    Message.create(chain_id: chain.id, sender_id: u2.id, receiver_id: u1.id, content: Faker::Lorem.sentence(word_count: 10))
  end
end

puts "#{Message.all.length} messages shared"


# Test Profile No. 1 - Mark

mark = User.create(
    name: "Mark Zuckerburg",
    email: "mark@facebook.com",
    password: "password1",
    mod_id: 1,
    accepted_terms: true
)

mark_profile = Profile.create(
  user_id: mark.id,
  sex: "Male",
  studies: Faker::Lorem.sentence(word_count: 2),
  phone_number: Faker::PhoneNumber.phone_number,
  screenname: Faker::Lorem.sentence(word_count: 1),
  interested_in: Faker::Lorem.sentence(word_count: 2),
  relationship_status: Faker::Lorem.sentence(word_count: 2),
  political_view_id: 5,
  interests: Faker::Lorem.sentence(word_count: 5),
  movies: Faker::Lorem.sentence(word_count: 3),
  music: Faker::Music.band,
  websites: Faker::Internet.url,
  about_me: Faker::Lorem.sentence(word_count: 10),
  photo_url: photo_urls.sample
)

mark_profile.generate_slug

#Give Mark 20 friends
10.times do 
    Friendship.create(user_1_id: mark.id, user_2_id: User.all.sample.id)
    Friendship.create(user_1_id: User.all.sample.id, user_2_id: mark.id)
end

puts "#{mark.name} has been created with #{mark.friends.length} friends."

# Give Mark 5 friend requests
5.times do 
  FriendRequest.create(requestor_id: User.all.sample.id, receiver_id: mark.id)
end

# Get Mark to send 5 friend requests
5.times do 
  FriendRequest.create(requestor_id: mark.id, receiver_id: User.all.sample.id)
end

puts "#{mark.name} has sent #{mark.friend_requests.length} friend requests and received #{mark.friend_requests_as_receiver.length} friend requests."

# Give Mark some message chains
5.times do 
  friend = mark.friends.sample
  chain = Chain.create()
  5.times do 
    # message sent by Mark...
    message = Message.create(chain_id: chain.id, sender_id: mark.id, receiver_id: friend.id, content: Faker::Lorem.sentence(word_count: 15) )
    # message sent to Mark by friend...
    Message.create(chain_id: chain.id, sender_id: friend.id, receiver_id: mark.id, content: Faker::Lorem.sentence(word_count: 10) )
  end
end

puts "#{mark.name} is part of #{mark.chains.length} message chains. He has shared #{mark.sent_messages.length} and has received #{mark.received_messages.length} messages."


# Test Profile No. 2 - Eduardo

eduardo = User.create(
    name: "Eduardo Saverin",
    email: "eduardo@facebook.com",
    password: "password1",
    mod_id: 1,
    accepted_terms: true
)

eduardo_profile = Profile.create(
  user_id: eduardo.id,
  sex: "Male",
  studies: Faker::Lorem.sentence(word_count: 2),
  phone_number: Faker::PhoneNumber.phone_number ,
  screenname: Faker::Lorem.sentence(word_count: 1),
  looking_for: Faker::Lorem.sentence(word_count: 1),
  relationship_status: Faker::Lorem.sentence(word_count: 2),
  political_view_id: 3,
  interests: Faker::Lorem.sentence(word_count: 5),
  movies: Faker::Lorem.sentence(word_count: 3),
  music: Faker::Music.band,
  websites: Faker::Internet.url,
  about_me: Faker::Lorem.sentence(word_count: 10),
  photo_url: photo_urls.sample
)

eduardo_profile.generate_slug

puts "#{eduardo.name} has been created with #{eduardo.friend_ids.length} friends."



