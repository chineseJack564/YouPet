
document.addEventListener('turbolinks:load', () => {
  main()
});

function main() {

  const htmlNotifications = document.querySelectorAll('.notif-container-own');

  Array.from(htmlNotifications).forEach(notif => {
    let container = notif.querySelector('.notif-del-own');
    let iconDel = `<i class="fas fa-times"></i>`;
    container.innerHTML = iconDel;
  });

  const htmlNotificationCont = document.querySelector('.notifications-container-own');
  const htmlNotificationReturn = document.querySelector('.notif-return-bar-own');

  try {
    htmlNotificationReturn.addEventListener('click', () => {
      htmlNotificationCont.classList.toggle('show-own');
      htmlNotificationCont.classList.remove('chat-extend-own');

      $(htmlNotificationCont).css({'transition': '1s'});
      setTimeout(() => {
        $(htmlNotificationCont).css({'transition': '0s'});
      }, 1000);
    });
  } catch (error) {}


  $('.notif-container-own').on('mouseenter', function(event) {
    $notif = $(event.target).closest('.notif-container-own');
    if ($notif.attr('unread') == 'true') {
      $id = $notif.attr('notif');
      $notif.find('.notif-new').css({'background-color': 'transparent'});
      console.log($id);
      $.ajax({
        type: 'POST',
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        url: '/notifications/update_n',
        data: {'id': $id}
      });
    }

  });

}
