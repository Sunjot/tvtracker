# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  # function for inserting show items into the popular/on air sections
  insertShowItems =(ajaxReq, section) ->
     $.ajax(ajaxReq).done (response) ->
       children = document.getElementById(section).children;
       for i in [0..4]
         if i in [0..1]
           src_url = "https://image.tmdb.org/t/p/w780" + response["results"][i]["backdrop_path"];
           sh_name = response["results"][i]["name"];
           children[i].getElementsByTagName('p')[1].innerHTML += sh_name;
         else
           src_url = "https://image.tmdb.org/t/p/w342" + response["results"][i]["poster_path"];

         poster_url = "https://image.tmdb.org/t/p/w342" + response["results"][i]["poster_path"];
         img_element = children[i].getElementsByTagName('img')[0];
         img_element.setAttribute('src', src_url);
         img_element.setAttribute('data-poster', poster_url);
         img_element.setAttribute('id', response["results"][i]["id"]);

  if document.getElementById('popular')?
    air_url = "https://api.themoviedb.org/3/tv/popular?language=en-US&api_key=9316c21a1d598842bf35b43bf3e3c502";
    airRequest = {type: 'get', url: air_url, async: true, crossDomain: true};
    insertShowItems(airRequest, 'popular');

  if document.getElementById('airing')?
    air_url = "https://api.themoviedb.org/3/tv/on_the_air?language=en-US&api_key=9316c21a1d598842bf35b43bf3e3c502";
    airRequest = {type: 'get', url: air_url, async: true, crossDomain: true};
    insertShowItems(airRequest, 'airing');

  if document.getElementById('suggested')?
      shid = document.getElementById('randomized').children[0].getAttribute('id');
      air_url = "https://api.themoviedb.org/3/tv/" + shid + "/recommendations?language=en-US&api_key=9316c21a1d598842bf35b43bf3e3c502";
      airRequest = {type: 'get', url: air_url, async: true, crossDomain: true};

      $.ajax(airRequest).done (response) ->
        children = document.getElementById('suggested-list').children;
        for i in [0..5]
          src_url = "https://image.tmdb.org/t/p/w342" + response["results"][i]["poster_path"];

          img_element = children[i].getElementsByTagName('img')[0];
          img_element.setAttribute('src', src_url);
          img_element.setAttribute('data-poster', src_url);
          img_element.setAttribute('id', response["results"][i]["id"]);

  $(document).off('click', '.discover-item').on 'click', '.discover-item', (e) =>

    ID = e["currentTarget"].getElementsByTagName('img')[0].getAttribute('id');
    src = e["currentTarget"].getElementsByTagName('img')[0].getAttribute('data-poster');

    $.ajax
      type: 'post'
      url: '/add'
      data: {shID: ID, shPoster: src}

    # animation for the confirmation message when a show is added
    # adds p tag showing confirmation, then removes after animation is done
    p_tag = document.createElement('p');
    p_tag.className = "conf-add";
    p_tag.innerHTML = "Show added!";
    document.getElementById('added-msg-cont').appendChild(p_tag);
    setTimeout =>
      cont = document.getElementById('added-msg-cont');
      cont.removeChild(cont.children[0]);
    , 3000
