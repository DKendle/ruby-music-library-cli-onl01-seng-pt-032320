require "pry"
class MusicLibraryController
  attr_accessor :path

  def initialize(path = "./db/mp3s")
    music_imp_obj = MusicImporter.new(path)
    music_imp_obj.import
  end

  def call
    input = ""
    while input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.chomp
    end
  end


    def list_songs
      #binding.pry
      Song.all.sort {|a,b| a.name <=> b.name}.uniq.each.with_index(1) do |song, i|
        puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end


  def list_artists
    Artist.all.sort {|a, b| a.name <=> b.name}.uniq.each.with_index(1) do |artist, i|
      puts "#{i}. #{artist.name}"
    end
  end

  def list_genres
    Genre.all.sort {|a, b| a.name <=> b.name}.uniq.each.with_index(1) do |genre, i|
      puts "#{i}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp
    if artist = Artist.find_by_name(input)
      artist.songs.sort { |a,b| a.name <=> b.name }.each.with_index(1) do |song, i|
        puts "#{i}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp
      if genre = Genre.find_by_name(input)
        genre.songs.sort { |a, b| a.name <=> b.name }.each.with_index(1) do |song, i|
          puts "#{i}. #{song.artist.name} - #{song.name}"
        end
      end
  end


  def play_song
    binding.pry
      puts "Which song number would you like to play?"
      self.list_songs
      input = gets.chomp.to_i


      if (input > 0) && (input <= self.list_songs.length)
        self.list_songs.find{|indexed_songs| indexed_songs[input-1] }
        puts "Playing #{song.name} by #{song.artist.name}"
      end

  end
end
