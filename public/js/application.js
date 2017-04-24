$(document).ready(function() {
  //show comments
  $(".toggle-comments").click(function() {
    $(this).next().toggleClass("comments-visible");
  });

  //log out
  $("#post-logout").click(function(e) {
    e.preventDefault();
    $.ajax({
      method: "POST",
      url: "/logout",
      success: function(data) {
        window.location.replace("/");
      },
      error: function(err) {
        alert("Failed to sign out");
        console.log(err);
      }
    });
  });
  //voting when not logged in
  $(".prompt-login").submit(function(e) {
    e.preventDefault();
    // alert("LOG IN FIRST");
  });

  //voting
  $(".vote-buttons").on("submit", ".vote", function(e) {
    // debugger
    // TODO prevent spam requests
    // with enough mashing, the buttons get jammed the buttons would be in the wrong state: i.e. removing an upvote that was already deleted.
    //currently only disable buttons
    e.preventDefault();
    var element = $(this);
    //this sphaghetti code disables the buttons
    //potentially not enough to prevent a user to spam me
    element.parent().find("input[type=submit]").prop("disabled", true)
    $.ajax({
      method: "POST",
      url: element.attr("action"),
      data: element.serialize(),
      dataType: "html",
      success: function(data) {
        // element.children("input").prop("disabled", false);
        // debugger
        console.log(data);
        element.parent().html(data);
      },
      error: function(err) {
        alert("Failed!");
        console.log(err);
      }
    });
  });

  $(".comment-button").click(function() {
    $("#modal-comment form").attr("action", "/answer/" + $(this).data("answer-id") + "/comment");
  });

});
