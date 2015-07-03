$(function() {
  $(".dropdown-menu").on('click', 'li a', function() {
    var clickedIcon = $(this);
    var ticketId = clickedIcon.parents('div.ticket-entry').find('input#id').val();
    var GetPanelForStatus = function(status) {
      if (status == 0 || status == 1) return $('.tickets-panels .panel-warning');
      if (status == 2) return $('.tickets-panels .panel-info');
      return $('.tickets-panels .panel-success');
    }

    var OnTicketUpdateSuccess = function(response) {
      var newPanel = GetPanelForStatus(response.status);
      clickedIcon.parents('div.ticket-entry').appendTo(newPanel);
    }

    var data = {
      ticket: {
      }
    };

    if (clickedIcon.parents('ul.cell').hasClass('status')) data.ticket.status = clickedIcon.find('i').attr('value');
    if (clickedIcon.parents('ul.cell').hasClass('owner')) data.ticket.user_id = clickedIcon.find('i').val();

    $.ajax({
        url: '/tickets/' + ticketId,
        method: "PUT",
        data: data,
        success: OnTicketUpdateSuccess
    });
  });

  $('.dropdown, textarea, button').click(function(e) {
    e.stopPropagation();
    if ($(this).prop('tagName') != 'BUTTON' && $(this).parents('.ticket-entry').hasClass('readonly')) return;
    $(this).find('a.dropdown-toggle').first().dropdown('toggle');
  });

  $(".ticket-entry").on('click', function() {
    $(this).find('.details').slideToggle(256);
  });

  $("button").on('click', function() {
    var ticketId = $(this).attr('id'),
        text = $(this).parents('.comments').find('textarea').val(),
        self = this;

    var OnCommentSuccess = function(response) {
      $(self).parents('.comments').find('.comments-list').append(response);
      $(self).parents('.comments').find('textarea').val('');
    };

    $.ajax({
      url: '/tickets/' + ticketId + '/comment',
      data: { comment: { text: text }},
      method: "POST",
      success: OnCommentSuccess
    });
  });
});
