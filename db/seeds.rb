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
Mod.create(name: "Lord of the Strings")
Mod.create(name: "Git Hurts When IP")
Mod.create(name: "Git Up and Pry Again")
Mod.create(name: "Scrumbags")

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
mark = User.create(
  name: "Mark Zuckerberg",
  email: "mark@facebook.com",
  birthday: DateTime.new(1984, 5, 14),
  password: "password1",
  mod_id: Mod.all.sample.id,
  accepted_terms: true
)

profile = Profile.create(
  user_id: User.last.id,
  sex: "Male",
  studies: "Your message history",
  hometown: "White Plains, NY",
  phone_number: Faker::PhoneNumber.phone_number,
  screenname: "Zuckonit",
  interested_in: "What you are doing.",
  political_view_id: 5,
  interests: "Human amusements that we humans enjoy",
  books: "World Order, Why Nations Fail, Sapiens",
  movies: "Anything but The Social Network",
  music: "The soft hum of a server room",
  websites: "www.facebook.com",
  about_me: "*screams in dial-up*",
  photo_url: "https://selftaught.blog/wp-content/uploads/2019/01/MarkZuckerberg.jpg"
)

mark.profile.generate_slug

eduardo = User.create(
  name: "Eduardo Saverin",
  email: "eduardo@notfacebook.com",
  birthday: DateTime.new(1982, 3, 19),
  password: "password1",
  mod_id: Mod.all.sample.id,
  accepted_terms: true
)

Profile.create(
  user_id: User.last.id,
  sex: "Male",
  studies: "Tax evasion",
  hometown: "São Paulo",
  phone_number: Faker::PhoneNumber.phone_number,
  screenname: "The Financier",
  interested_in: "Women",
  political_view_id: 5,
  interests: "Renouncing my US citizenship.",
  books: "Great Expectations",
  movies: "The Social Network",
  music: "Mark trying to testify before the Senate",
  websites: "www.facebook.com",
  about_me: "Hey guys, remember me?",
  photo_url: "https://nyobetabeat.files.wordpress.com/2012/05/eduardo-saverin-thherichest-org.jpeg?quality=80"
)

eduardo.profile.generate_slug