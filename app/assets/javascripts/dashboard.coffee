# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready turbolinks:load', ->

  # prevents caching so results dont load over previously displayed results
  document.addEventListener "turbolinks:before-cache", () =>
    $(".all_shows").empty()

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

  $(document).off('ajax:success', '.button_to').on 'ajax:success', '.button_to', (e) =>

    id = e["currentTarget"].parentElement.className.split(" ")[1] # get show id of show removed

    $.ajax # take the id of the show and hit the remove action to delete from the db
      type: 'post'
      url: '/remove'
      data: { shID: id }

    e["currentTarget"].parentElement.style.opacity = "0" # fade out before removing from page

    setTimeout -> # fadeout takes 0.5s, and then we remove from page after 0.6s
      e["currentTarget"].parentElement.remove();
    , 600
