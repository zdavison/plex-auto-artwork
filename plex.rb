require "fileutils"
require "date"

DIR = ARGV[0]
FILENAME_BACKGROUND = "artist-background"
FILENAME_POSTER = "artist-poster"

Dir.chdir(DIR)
folders = Dir.glob('**/*').select {|f| File.directory? f}

folders.each do |folder|
  contains_music      = Dir.glob(folder + '/*.{mp3,flac}').count > 0
  contains_background = Dir.glob(folder + '/' + FILENAME_BACKGROUND + ".{jpg,jpeg}").count > 0
  contains_poster     = Dir.glob(folder + '/' + FILENAME_POSTER + ".{jpg,jpeg}").count > 0

  if contains_music then
    largest = Dir.glob(folder + '/*.{jpg,jpeg}').sort_by{ |image| File.size?(image) }.last
    FileUtils.cp(File.path(largest), File.dirname(largest) + "/" + FILENAME_BACKGROUND + File.extname(largest)) unless contains_background
    FileUtils.cp(File.path(largest), File.dirname(largest) + "/" + FILENAME_POSTER + File.extname(largest)) unless contains_poster
    
    timestamp = DateTime.now.strftime("%d/%m/%Y %H:%M")
    puts timestamp + ">Created background in '#{folder}'" unless contains_background
    puts timestamp + ">Created poster in '#{folder}'"     unless contains_poster
  end
end
