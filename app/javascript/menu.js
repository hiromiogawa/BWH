$(function() {
  var toggleMenu = $('#toggle_menu'),
			toggleMenuWidth,
      toggle = function() {
        toggleMenuWidth = toggleMenu.outerWidth();
        if ( window.innerWidth < 768 ) {
          if ( $('header .menu').hasClass('pushed') == true ) {
            toggleMenu.css({'right' : 0, 'opacity' : 1 });
          } else {
            toggleMenu.css({'right' : - toggleMenuWidth , 'opacity' : 1 });
          }
        }
      }

      toggle();

  $(window).on('resize', function(){
    toggle();
  });

  $('.menu').on('click', function(){
		toggleMenuWidth = toggleMenu.outerWidth();
		if ( $('header .menu').hasClass('pushed') == true ) {
			toggleMenu.animate({'right' : - toggleMenuWidth }, 300);

		} else {
			$('header .bg-area').addClass('opened');
			toggleMenu.animate({'right' : 0 }, 300);
		}
		$('header .menu').toggleClass('pushed');
		toggleMenu.toggleClass('active');
	});
});
