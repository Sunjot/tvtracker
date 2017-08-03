# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  air_url = "https://api.themoviedb.org/3/tv/on_the_air?language=en-US&api_key=9316c21a1d598842bf35b43bf3e3c502"
  airRequest = {type: 'get', url: air_url, async: true, crossDomain: true}

  $.ajax(airRequest).done (response) ->

    for i in [0..8]
      console.log(response["results"][i])
      poster_url = 'http://image.tmdb.org/t/p/w185' + response["results"][i]["poster_path"]
      child = '<div class="popular-show"><img src="' + poster_url + '"/></div>'
      $('#popular').append(child)
