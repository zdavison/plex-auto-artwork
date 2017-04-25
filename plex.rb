require "fileutils"
require "date"

DIR = ARGV[0]
FILENAME_BACKGROUND = "artist-background"
FILENAME_POSTER = "artist-poster"

def timestamp
  DateTime.now.strftime("%d/%m/%Y %H:%M")
end

def escape_glob(s)
  s.gsub(/[\\\{\}\[\]\*\?]/) { |x| "\\"+x }
end

Dir.chdir(DIR)
folders = Dir.glob('**/*').select {|f| File.directory? f}

puts timestamp() + ">>> Beginning plex-auto-artwork.."

folders.each do |folder|
	
	escaped_folder = escape_glob(folder)
	mp3_glob 		= escaped_folder + '/*.{mp3,flac}'
	background_glob		= escaped_folder + '/' + FILENAME_BACKGROUND + ".{jpg,jpeg}"
	poster_glob		= escaped_folder + '/' + FILENAME_POSTER + ".{jpg,jpeg}"

  contains_music      = Dir.glob(mp3_glob).count > 0
  contains_background = Dir.glob(background_glob).count > 0
  contains_poster     = Dir.glob(poster_glob).count > 0

	puts "Inspecting> " + folder + " |#{contains_music}|#{contains_background}|#{contains_poster}|"

  if contains_music then
    largest = Dir.glob(escaped_folder + '/*.{jpg,jpeg}').sort_by{ |image| File.size?(image) }.last
    FileUtils.cp(File.path(largest), File.dirname(largest) + "/" + FILENAME_BACKGROUND + File.extname(largest)) unless contains_background
    FileUtils.cp(File.path(largest), File.dirname(largest) + "/" + FILENAME_POSTER + File.extname(largest)) unless contains_poster
    
    puts timestamp() + "> Created background in '#{folder}'" unless contains_background
    puts timestamp() + "> Created poster in '#{folder}'"     unless contains_poster
  end
end

puts timestamp() + "<<< Ending plex-auto-artwork.."
