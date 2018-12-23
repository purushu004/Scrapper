$(document).ready ->
  $(document).on "click", "#submit", (event) ->
    link = $("#link_input").val()
    console.log(link)
    $.ajax {
      type:"POST",
      url: "/test",
      data: "link=" + link,
      success:(data) ->
        console.log(data)
      failure: ->
        alert("failed")
    }


