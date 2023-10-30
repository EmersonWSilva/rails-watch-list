require 'open-uri'
require 'json'

puts "Cleaning up db"
Movie.destroy_all
puts "DB Cleaned!"

url = "http://tmdb.lewagon.com/movie/top_rated"
1.times do |i|
  puts "Importing Movies from page #{i + 1}"
  movies = JSON.parse(URI.open("#{url}?page=#{i+1}").read)['results']
  movies.each do |movie|
    puts "Creating #{movie['title']}"
    base_poster_url = "https://image.tmdb.org/t/p/original"
    Movie.create(
      title: movie['title'],
      overview: movie['overview'],
      poster_url: "#{base_poster_url}#{movie['backdrop_Path']}",
      rating: movie['vote_average']
    )
  end
end
puts "Movies Created!"
