require "fileutils"

DIR = ARGV[0]
FILENAME_BACKGROUND = "artist-background"
FILENAME_POSTER = "artist-poster"

Dir.chdir(DIR)
folders = Dir.glob('**').select {|f| File.directory? f}

folders.each do |folder|
  contains_music = Dir.glob(folder + '/*.{mp3,flac}').count > 0
  if contains_music then
    largest = Dir.glob(folder + '/*.{jpg,jpeg}').sort_by{ |image| File.size?(image) }.last
    FileUtils.cp(File.path(largest), File.dirname(largest) + "/" + FILENAME_BACKGROUND + File.extname(largest))
    FileUtils.cp(File.path(largest), File.dirname(largest) + "/" + FILENAME_POSTER + File.extname(largest))
  end
end
