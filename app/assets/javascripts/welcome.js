
$(document).on('turbolinks:load', function() {
  welcome_main();
  sidebar_main();
});

function welcome_main() {

  try {
    var rellax = new Rellax('.rellax');  
  } catch (error) {}

  let deactive = false;
  $('.nav-icon-container-own').on('click', function(e) {
    e.preventDefault();

    var $previous = $('.current-option-container-own.active-option-own');
    var $caller = $(this).attr('class').split(' ')[1];
    var $openNot = $('.notifications-container-own');

    $openNot.removeClass('chat-extend-own');
    if (!deactive) {
      if ($previous.attr('tag') !== $(this).attr('tag')) {
        $previous.addClass('exit-animate-own');
        deactive = true;
        $previous.on('animationend', function() {
          $previous.removeClass('exit-animate-own');
          deactive = false;
        });
      }

      if (!$openNot.hasClass('show-own')) {
        $openNot.toggleClass('show-own');
        $openNot.css({'transition': '1s'});
        setTimeout(() => {
          $openNot.css({'transition': '0s'});
        }, 1000);
      }
      $openNot.children('.current-option-container-own').each(function(_, child) {
        $(child).removeClass('active-option-own');
      });

      $openNot.find(`.${$caller}`).addClass('active-option-own');
    }
  });

}


function sidebar_main() {
  $('.switch').on('click', function(e) {
    e.preventDefault();

    $('#check-input').prop('checked', !$('#check-input').prop('checked'));
    $(document).trigger('darkmode');

    var $targets = [
      $('html'),
      $('body'),
      $('.header-sticky'),
      $('.bg-name-primary'),
      $('.bg-name-bright'), 
      $('.bg-name-light'),
      $('.bg-name-text'),
      $('input[type=search]'),
      $('input[type=text]'),
      $('select')
    ];

    $.each($targets, function(_, target) {

      $(target).toggleClass('dark-own');
    });

    $mode = $('.lightmode_logo').css('display');
    $other = $mode == 'none' ? 'block' : 'none';
    $('.lightmode_logo').css({'display': $other})
    $('.darkmode_logo').css({'display': $mode})

  });
}
