
class User < ActiveRecord::Base

  has_many :follows
  has_many :artists, through: :follows

  def self.find_or_create_by_name(name)
    user = User.find_by(name: name)
    if user
      puts "Welcome back, #{user.name}!"
      user
    else
      User.create(name: name)
      puts "Hello, #{name}! We're happy you joined us!"
      user
    end
  end

  def follow_artist(artist_name)
    artist_name = artist_name.downcase
    artist = Artist.find_or_create_by_artist_name(artist_name)
    if self.artists.include?(artist)
      puts "You've already added this artist!"
    else
      Follow.find_or_create_by(user_id: self.id, artist_id: artist.id)
      self.artists << artist
    end
  end

  def show_own_artists
    puts "--------------------------------------"

    puts "The artists you currently follow are:"
    puts "--------------------------------------"
    self.artists.each do |artist|
      puts artist.name.capitalize
  end
  puts " "
  puts " "
end

def artists_array
  array = []
  self.artists.each do |artist|
    array << artist.name
  end
  array.uniq
end

def get_events_from_follows
  self.artists.map {|art| art.events}
end


def put_out_concerts_by_area(location)
  puts "--------------------------------------------------------------"
  puts "Here are the artists you follow that are playing in this area:"
  puts "--------------------------------------------------------------"
# byebug
  Event.search_for_concerts_by_area(location).each do |event|
    if self.artists_array.include?(Artist.find_by(id: event.artist_id).name)
    puts "#{Artist.find_by(id: event.artist_id).name.capitalize}"
    #need to change to only artists user follows
    puts "#{event.name.capitalize}"
    puts "#{event.location}"
    puts "Date: #{event.date}"
    puts "###################################"
  end
  end
end


end
