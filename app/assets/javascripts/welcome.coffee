# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  if document.getElementById('popular')?
    air_url = "https://api.themoviedb.org/3/tv/on_the_air?language=en-US&api_key=9316c21a1d598842bf35b43bf3e3c502"
    airRequest = {type: 'get', url: air_url, async: true, crossDomain: true}

    $.ajax(airRequest).done (response) ->

      children = document.getElementById('popular').children;
      for i in [0..9]
        poster_url = "http://image.tmdb.org/t/p/w185" + response["results"][i]["poster_path"]
        img_element = children[i].getElementsByTagName('img')[0];
        img_element.setAttribute('src', poster_url);
        img_element.setAttribute('id', response["results"][i]["id"])

  $(document).off('click', '.popular-show').on 'click', '.popular-show', (e) =>

    ID = e["currentTarget"].getElementsByTagName('img')[0].getAttribute('id');
    src = e["currentTarget"].getElementsByTagName('img')[0].getAttribute('src');

    $.ajax
      type: 'post'
      url: '/add'
      data: {shID: ID, shPoster: src}

    # animation for the confirmation message when a show is added
    # adds p tag showing confirmation, then removes after animation is done
    p_tag = document.createElement('p');
    p_tag.className = "conf-add"
    p_tag.innerHTML = "Show added!";
    document.getElementById('added-msg-cont').appendChild(p_tag);
    setTimeout =>
      cont = document.getElementById('added-msg-cont');
      cont.removeChild(cont.children[0])
    , 3000
