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

      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end

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
      puts "Which song number would you like to play?"
        # self.list_songs
      input = gets.chomp.to_i
        if (input > 0) && (input <= Song.all.length)
          # Song.all.sort{|indexed_song_obj| indexed_song_obj[[input-1]] }
          song = Song.all.sort{|a, b| a.name <=> b.name}.uniq[input-1]
          puts "Playing #{song.name} by #{song.artist.name}" if song
            end
          end


        # def play_song
        #   puts "Which song number would you like to play?"
        #   list_of_songs =  Song.all.sort{ |a, b| a.name <=> b.name }
        #   input = gets.chomp.to_i
        #
        #
        #   #
        #   # if (1..Song.all.length).include?(input)
        #   #    song = list_of_songs[input+2]
        #   #    puts "Playing #{song.name} by #{song.artist.name}"
        #   #  else
        #   #    #binding.pry
        #   #  end
        # end
        #


end
