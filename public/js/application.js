$(document).ready(function() {
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
});
