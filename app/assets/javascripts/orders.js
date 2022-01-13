
$(document).on('turbolinks:load', function() {

  clickScrollListener('[action=place_order]', '#review-tab', '#connect-4');

  clickScrollListener('[action=send_message]', '#contact-tab', '#connect-3');

});

function clickScrollListener(action, container, container_new) {
  $(action).on('click', function(event) {
    event.preventDefault();

    $('html, body').animate({
      "scrollTop": $("#tab-section-container").offset().top - 100
    });

    $('#myTab').children().each(function(_, element) {
      $(element).children().removeClass('active');
      $(element).children().attr('aria-selected', 'false');
    });

    $(container).addClass('active');
    $(container).attr('aria-selected', 'true');

    $('#myTabContent').children().each(function(_, element) {
      $(element).removeClass('active');
      $(element).removeClass('show');
    });

    $(container_new).addClass('active');
    $(container_new).addClass('show');

  });
}
