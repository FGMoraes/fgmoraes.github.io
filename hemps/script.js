function sticky_relocate() {
  var window_top = $(window).scrollTop();
  var div_top = $('#floating_menu-anchor').offset().top;
  if (window_top > div_top) {
    $('#floating_menu').addClass('floating_menu');
    $('#floating_menu-anchor').height($('#floating_menu').outerHeight());
  } else {
    $('#floating_menu').removeClass('floating_menu');
    $('#floating_menu-anchor').height(0);
  }
}

$(function() {
  $(window).scroll(sticky_relocate);
  sticky_relocate();
});

