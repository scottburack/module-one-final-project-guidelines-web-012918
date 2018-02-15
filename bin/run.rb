require_relative '../config/environment.rb'
require_relative '../app/model/artist'
require_relative '../app/model/follow'
require_relative '../app/model/user'
require_relative '../app/model/event'
require "byebug"

def run

  puts 'Hello. What is your name?'
  name = gets.chomp
  user = User.find_or_create_by_name(name)
  answer = nil
  until answer == 5
    puts "-------------------------"
  puts "What would you like to do today?"
  puts "List:"
  puts "-------------------------"
  puts "1. My Artists"#Complete
  puts "2. Search For An Artist"#Complete
  puts "3. Follow Artist"#Complete
  puts "4. Check to see if your artists are playing by you!"#complete
  puts "5. Exit"
  answer = gets.chomp

  case answer
  when "1"
    user.show_own_artists
  when "2"
    puts "Please enter an artist name:"
    artist_name = gets.chomp
    artist = Artist.find_or_create_by_artist_name(artist_name)
    artist.get_events_by_artist(artist.name)
  when "3"
    puts "Which artist would you like to follow?"
    artist_to_follow = gets.chomp
    user.follow_artist(artist_to_follow)
    # byebug
  when "4"
    puts "Please enter a location."
    puts "ex. 'New York, NY' or 'Chicago, IL'"
    area = gets.chomp
    user.put_out_concerts_by_area(area)

when "5"
  return
end
end
end

run

# s = User.new("scott")
# s.get_events_from_follows

#
#
# byebug
#
# "yoooo"
