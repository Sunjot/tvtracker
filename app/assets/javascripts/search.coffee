# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready turbolinks:load', ->

  #
  #
  # BUTTON SELECTION
  # Couldn't just use .button_to for the selector because the dashboard controller also has an
  # ajax success method. The distinction prevents the two from interfering and causing issues on button clicks
  # NOTE: .off and .on are both included because it causes double execution otherwise (not solved yet)
  $(document).off('ajax:success', '.show_but >> .button_to').on 'ajax:success', '.show_but >> .button_to', (e) =>

    button_class_name = e["currentTarget"].firstElementChild.className.split(" ")[0];

    #
    # if the add button is clicked
    if button_class_name == "add_show"

      # stored name_element because it gets reused in order to get all 3 pieces of info
      name_element = e["currentTarget"].parentElement.parentElement.previousElementSibling;

      name = name_element.innerHTML # show name
      id = name_element.parentElement.parentElement.className.split(" ")[3]; # show id
      poster = name_element.parentElement.previousElementSibling.firstElementChild.src; # show poster

      $.ajax # send ajax request to server with relevant info to store in db
        method: "POST"
        url: "/add"
        data: {shName: name, shID: id, shPoster: poster}

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

  #
  #
  # OTHER JS
  # Reset the search results to display nothing before the search page gets cached
  # This way when we revisit it doesn't restore previous results
  document.addEventListener "turbolinks:before-cache", () ->
    $(".search_results").empty()
    $(".search_form").val('') # clear text in the input form
