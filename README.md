# mainstream-spotify

idea:
determine the most popular genres and songs on spotify and develop some web interface to compare their qualities

link: https://yojiki94.shinyapps.io/spotifyapp/

contents:
topsongs.dat - collection of approx 120000 songs over approx 200 genres consisting of what is "mainstream" on spotify
app.R - R code for the rshiny app
mainstreamgenres.Rmd - R code for the scraping of data from everynoise.com and spotify

process:
1) scrape the most popular genres on spotify from http://everynoise.com/everynoise1d.cgi?scope=mainstream%20only&vector=popularity  (updated quite frequently. reproducing the process will result in more genres and songs gathered than I have)

2) using the spotify api, turn each playlist of genres into track ID's, and then using track ID's, gather their audio features as described in https://developer.spotify.com/documentation/web-api/reference/tracks/get-several-audio-features/

3) create a webapp using rshiny. thought it would be most interesting to view as scatterplot and as tabular data in order to compare.
