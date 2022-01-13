
$(document).on('turbolinks:load', function() {
  chats_main();
});

function chats_main() {
  $('.fa-expand-alt').on('click', function() {
    $('.notifications-container-own').css({'transition': '1s'});
    setTimeout(() => {
      $('.notifications-container-own').css({'transition': '0s'});
    }, 1000);
    $('.notifications-container-own.show-own').toggleClass('chat-extend-own');
  });

  $(document).on('pusher', function(event, arg) {

    if ($('[num=messages]').attr('user') == arg.recipient.id) {

      if (!$(`#chat${arg.chat.id}`).hasClass('message-history-shown')) {

        $('[num=messages]').text(arg.recipient.unread_messages);

        if (arg.chat.recipient_id == arg.recipient.id) {
          $(`[chat=${arg.chat.id}]`).text(arg.chat.recipient_unreads);
        }
        else {
          $(`[chat=${arg.chat.id}]`).text(arg.chat.sender_unreads);
        }
        $('[num=messages]').css({'background-color': '#f6ab49'});
        $(`[chat=${arg.chat.id}]`).css({'background-color': '#f6ab49'});
      }

      else {
        /* ROLLBACK COUNTER */
        console.log('ROLLBACK');

       
        
        $(`[chat=${arg.chat.id}]`).trigger('rollbackIncrement');
      }

    }
  });
}
