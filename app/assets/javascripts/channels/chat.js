
$(document).on('turbolinks:load', function() {
  $('.message-history-own').each(function(_, element) {
    subscribeChat(element);
  });

  $(document).on('subscriptionSignal', function(event, chat) {
    subscribeChat(chat);
    console.log('subscribed');
  });
});

function subscribeChat(element) {
  App.cable.subscriptions.create(
  {
    channel: 'ChatChannel',
    chat: $(element).attr('id').slice(-1)
  },
  {
    connected: function() {
    },
    received: function(data) {

      var msg = data["message"];

      $(element).append(msg);
      $(element).scrollTop(element.scrollHeight);
      $(element).trigger('pusher', {
        chat: data['chat'],
        sender: data['sender']['id'],
        recipient: data['recipient']
      });

      $chat = $(element).attr('id');
      $msgHTMLtxt = $($.parseHTML(data['message'])[1]).find('.fullmsg-own').text();
      $msgHTMLtime = $($.parseHTML(data['message'])[1]).find('.message-time-own').text();

      $(".message-user-own." + $chat).find('.message-user-last-own').html($msgHTMLtxt);
      $(".message-user-own." + $chat).find('.message-user-time-own').html($msgHTMLtime);
    }
  });
}
