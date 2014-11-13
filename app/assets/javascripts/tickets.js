$(function() {
  $(".dropdown-menu").on('click', 'li a', function(e){
    var GetUpdateDetails = function(element) {
      var field = element.attr('class').split('-')[1];
      return {
        field: field,
        ticketEntry: element.parents('.ticket-entry'),
        oldValue: element.parents('.ticket-entry').find('.ticket-' + field + '-icon').attr('value')
      }
    }

    var GetPanelForStatus = function(status) {
      if (status == 0 || status == 1) return $('.tickets-panels .panel-warning');
      if (status == 2) return $('.tickets-panels .panel-info');
      return $('.tickets-panels .panel-success');
    }

    var OnTicketUpdateSuccess = function(response) {
      updateDetails.ticketEntry.find('.ticket-' + response.field + '-icon')
        .removeClass()
        .addClass('ticket-' + response.field + '-icon fa ' + response.iconClass)
        .attr('title', response.title);

      if (updateDetails.field == 'status' && response.value != updateDetails.oldValue) {
        var panel = GetPanelForStatus(response.value);
        updateDetails.ticketEntry.appendTo(panel);
      }
    }

    var updateDetails = GetUpdateDetails($(this)),
        updatingTicketId = updateDetails.ticketEntry.find('input').val(),
        data = {
          field: updateDetails.field,
          value: $(this).find('i').attr('value')
        };

    $.ajax({
        url: '/tickets/' + updatingTicketId,
        method: "PATCH",
        data: data,
        success: OnTicketUpdateSuccess
    });
  });

  $('.dropdown').click(function(e) {
    $(this).find('a.dropdown-toggle').first().dropdown('toggle');
    e.stopPropagation();
  });

  $(".ticket-entry").on('click', function() {
    $(this).find('.description').slideToggle(256);
  });
});
