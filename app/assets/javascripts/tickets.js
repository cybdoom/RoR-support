$(function() {
  $(".dropdown-menu").on('click', 'li a', function(){
    var GetUpdateDetails = function(element) {
      return {
        field: $(element).attr('class').split('-')[1],
        ticketEntry: $(element).parents('.ticket-entry')
      }
    }

    var OnTicketUpdateSuccess = function(response) {
      updateDetails.ticketEntry.find('.ticket-' + response.field + '-icon')
        .removeClass()
        .addClass('fa ' + response.iconClass)
        .attr('title', response.title);
    }

    var updateDetails = GetUpdateDetails(this);
    var updatingTicketId = updateDetails.ticketEntry.find('input').val();
    var data = {
      field: updateDetails.field,
      value: $(this).find('i').attr('value')
    }

    $.ajax({
        url: '/tickets/' + updatingTicketId,
        method: "PATCH",
        data: data,
        success: OnTicketUpdateSuccess
    });
  });
});
