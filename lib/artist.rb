require "pry"
class Artist
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

  def add_song(song)

      if song.artist != self
      song.artist = self
    else
      song.artist
    end
    if !(@songs.include?(song))
      @songs << song
    else
      @songs
    end
  end


  def genres
    songs.collect{|song| song.genre}.uniq
  end


  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(artist_name)

    artist_obj = Artist.new(artist_name)
      if !(@@all.include?(artist_obj))
        @@all << artist_obj
      end
    artist_obj
  end
  # def self.create(song_name)
  #   song_obj = Song.new(song_name)
  #   if !(@@all.include?(song_obj))
  #     @@all << song_obj
  #   end
  #   song_obj
  #
  # end


end
