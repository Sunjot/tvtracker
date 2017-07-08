# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready turbolinks:load', ->

  #
  #
  # TAB SECTION
  if document.getElementById("sched-click")? # check if it exists first
    document.getElementById("sched-click").addEventListener "click", (e) =>
      document.getElementsByClassName("tab-container")[0].style.marginLeft = "-100%" # for the actual content
      document.getElementById("slide-hr").style.marginLeft = "55%" # for the slide bar under headers
      document.getElementById("slide-hr").style.width = "45%"

  if document.getElementById("coll-click")? # same as above, except for collection tab
    document.getElementById("coll-click").addEventListener "click", (e) =>
      document.getElementsByClassName("tab-container")[0].style.marginLeft = "0%";
      document.getElementById("slide-hr").style.marginLeft = "0%";
      document.getElementById("slide-hr").style.width = "48%";

  #
  #
  # BUTTON SECTION
  # Couldn't just use .button_to for the selector because the search controller also has an
  # ajax success method. The distinction prevents the two from interfering and causing issues on button clicks
  # NOTE: .off and .on are both included because it causes double execution otherwise (not solved yet)
  $(document).off('ajax:success', '.poster-container > .button_to').on 'ajax:success', '.poster-container > .button_to', (e) =>

    # either 'remove' or 'info' based on which button is clicked
    button_class_name = e["currentTarget"].getElementsByClassName('btn')[0].className.split(" ")[0]
    id = e["currentTarget"].parentElement.className.split(" ")[1] # get show id

    #
    # if remove button is clicked
    if button_class_name == "remove"

      $.ajax # take the id of the show and hit the remove action to delete from the db
        type: 'post'
        url: '/remove'
        data: { shID: id }

      e["currentTarget"].parentElement.style.opacity = "0" # fade out before removing from page

      setTimeout -> # fadeout takes 0.5s, and then we remove from page after 0.6s
        e["currentTarget"].parentElement.remove();
      , 600

    #
    # if info button is clicked
    if button_class_name == "info"
      myUrl = "";
      myUrl = "https://api.themoviedb.org/3/tv/" + id + "?language=en-US&api_key=9316c21a1d598842bf35b43bf3e3c502"

      tvInfoRequest = { "async": true, "crossDomain": true, "url": myUrl, "method": "GET" }

      # ajax request to get data about the tv show clicked on
      $.ajax(tvInfoRequest).done (response) ->
        if response["name"] != null
          genre_list = "";
          slash = 0;

          # go through each genre and list them seperated by a slash
          response["genres"].forEach (item) ->
            if (slash == 0)
              genre_list = genre_list + item.name;
              slash = 1;
            else
              genre_list = genre_list + "/" + item.name;

          # pull out the year from the date
          date = response["first_air_date"].split("-")[0];

          # insert show data into modal
          $(".show-info").html ->
            '<div class="show-pic"> \
              <img src="https://image.tmdb.org/t/p/w185' + response["poster_path"] + '"></img> \
            </div> \
            <div class="show-desc-cont"> \
              <div class="show-header"> \
                <h3 class="modal-title">' + response["name"] + '</h3> \
                <h4 class="show-date">(' + date + ') </h4> \
              </div> \
              <span class="show-genres">' + genre_list + '</span>\
              <hr class="top-line"></hr> \
              <span class="modal-show-desc">' + response["overview"] + '</span>\
            </div>'

  #
  #
  # SHOW SCHEDULES



  #
  #
  # SCHED DATES
  # inserts the dates for the coming week into the schedule container
  if document.getElementsByClassName("day-cont")[0]?
    document.getElementById("day-three-date").innerHTML = moment().add(2, 'days').format('MMMM DD');
    document.getElementById("day-four-date").innerHTML = moment().add(3, 'days').format('MMMM DD');
    document.getElementById("day-five-date").innerHTML = moment().add(4, 'days').format('MMMM DD');
    document.getElementById("day-six-date").innerHTML = moment().add(5, 'days').format('MMMM DD');
    document.getElementById("day-seven-date").innerHTML = moment().add(6, 'days').format('MMMM DD');

  #
  #
  # OTHER JS
  # prevents caching so results dont load over previously displayed results
  document.addEventListener "turbolinks:before-cache", () =>
    $(".all_shows").empty()

    # resets to the collection tab when leaving the page
    if document.getElementsByClassName("tab-container")[0]?
      document.getElementsByClassName("tab-container")[0].style.marginLeft = "0%";
      document.getElementById("slide-hr").style.marginLeft = "0%";
      document.getElementById("slide-hr").style.width = "48%";
