$(function() {
  var param = location.search,
      removeActive = function() {
        $('#login').removeClass('active');
        $('header').addClass('active');
        setTimeout(removeActive2, 1000);
      }

      removeActive2 = function() {
        $('header').removeClass('active');
      }


  if (param == "?statsu=login") {
    $('#login').addClass('active');
    $('#login.active img').fadeIn(3000);
    setTimeout(removeActive, 3300);
  }
});
