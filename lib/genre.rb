require "pry"
class Genre
  attr_accessor :name, :songs
  extend Concerns::Findable

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
    self.save
  end

  def save
    @@all << self
  end

  def artists
    songs.collect{|song| song.artist}.uniq
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(genre_name)
    genre_obj = Genre.new(genre_name)
      if !(@@all.include?(genre_obj))
        @@all << self
      end
    genre_obj
  end


end
