require 'json'
file = File.read('MyActivity.json')
music_data = JSON.parse(file)

print "Enter a start year: "
start_year = gets.to_i
print "Enter an end year: "
end_year = gets.to_i
print "How many of your top songs and artists would you like displayed: "
num_to_display = gets.to_i

times_listened = Hash.new(0)
artists_listened = Hash.new(0)
total_listen_time = 0

for i in 1..(music_data.length() - 1)
  
  song = music_data[i]
  song_year = song["time"].split(/-/, 2)[0].to_i
  song_name = song["title"].split(/\s/, 3)[2]
  
  if song_year < start_year  # Stops loop from running if already past relevant data
    break
  elsif (song_year <= end_year) && (song["title"].include? "Listened to") && (!(music_data[i - 1]["title"].include? "Skipped #{song_name}"))
    # Runs only if the song is in the correct time frame and also was not immediately skipped

    artist = song["description"]
    song_name += " - #{artist}"
    
    times_listened[song_name] -= 1
    artists_listened[artist] -= 1
    total_listen_time += 3

  end
end



puts "\n\n\n\n\nAssuming an average song time of 3 minutes, you listened to #{total_listen_time} minutes, or about #{total_listen_time / 60} hours, worth of music!\n\n\n"

puts "Your #{num_to_display} most listened to songs were:"
counter = 0
times_listened.sort_by { |_, value| value }.each do |key, value|
  if counter >= num_to_display
    break
  else
    puts("#{key} (#{-value})")
    counter += 1
  end
end

puts "\n\n\nYour #{num_to_display} most listened to artists were:"
counter = 0
artists_listened.sort_by { |_, value| value }.each do |key, value|
  if counter >= num_to_display
    break
  else
    puts("#{key} (#{-value})")
    counter += 1
  end
end



