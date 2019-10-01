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
Friendship.delete_all
Message.delete_all
GroupUser.delete_all
Chain.delete_all


# Create mods
Mod.create(name: "GitPushGitPaid")
Mod.create(name: "2b||!2b")
Mod.create(name: "!false")

puts "#{Mod.all.length} mods created"


# Create users
50.times do 
    User.create(
        name: Faker::Name.unique.name,
        email: Faker::Internet.unique.email,
        password: "123456",
        mod_id: Mod.all.sample.id,
        accepted_terms: true
    )

    Profile.create(
      user_id: User.last.id,
      sex: Faker::Gender.binary_type,
      studies: Faker::Lorem.sentence(word_count: 2),
      phone_number: Faker::PhoneNumber.phone_number,
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


# Create friendships
20.times do 
    Friendship.find_or_create_by(status: "Accepted", user_id: User.all.sample.id, friend_id: User.all.sample.id)
end

puts "#{Friendship.all.length} friendships created"


# Create chains
10.times do 
  Chain.create()
end

puts "#{Chain.all.length} chains started"

# Create messages
Chain.all.each do |chain|
  u1 = User.all.sample
  u2 = User.all.sample

  2.times do 
    Message.create(chain_id: chain.id, sender_id: u1.id, receiver_id: u2.id, content: Faker::Lorem.sentence(word_count: 5))
    Message.create(chain_id: chain.id, sender_id: u2.id, receiver_id: u1.id, content: Faker::Lorem.sentence(word_count: 5))
  end
end

puts "#{Message.all.length} messages shared"

#Test Profile No. 1 - Mark

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
  photo_url: photo_urls.sample
)

mark_profile.generate_slug

# Give Mark 10 friends
10.times do 
    @friendship = Friendship.new(status: "Accepted", user_id: mark.id, friend_id: User.all.sample.id)
    if @friendship.valid?
      @friendship.save 
    end
end

# Give Mark message chains with messages
marks_message_chains = []
5.times do 
  marks_message_chains << Chain.create()
end

marks_message_chains.each do |chain|
  friend = mark.accepted_friends.sample
  # give each chain four messages
  2.times do 
    Message.create(chain_id: chain.id, sender_id: mark.id, receiver_id: friend.id, content: Faker::Lorem.sentence(word_count: 5))
    Message.create(chain_id: chain.id, sender_id: friend.id, receiver_id: mark.id, content: Faker::Lorem.sentence(word_count: 5))
  end
end

puts "#{mark.name} has been created with #{mark.accepted_friends.length} friends. He has sent #{mark.sent_messages.length} messages and received #{mark.received_messages.length} messages within #{mark.chains.length} chains."


# Test Profile No.2 - Eduardo

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
  interested_in: Faker::Lorem.sentence(word_count: 2),
  relationship_status: Faker::Lorem.sentence(word_count: 2),
  political_views: Faker::Lorem.sentence(word_count: 1),
  interests: Faker::Lorem.sentence(word_count: 5),
  movies: Faker::Lorem.sentence(word_count: 3),
  music: Faker::Music.band,
  websites: Faker::Internet.url,
  about_me: Faker::Lorem.sentence(word_count: 10),
  photo_url: photo_urls.sample
)

eduardo_profile.generate_slug

puts "#{eduardo.name} has been created with #{eduardo.accepted_friends.length} friends. He has sent #{eduardo.sent_messages.length} messages and received #{eduardo.received_messages.length} messages."



