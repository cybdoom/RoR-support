$(function() {
  $(".dropdown-menu").on('click', 'li a', function(){
    var clickedIcon = $(this).find('i'),
        icon = $(this).parents(".status").find(".status-icon"),
        selectedClass = (new RegExp('fa-[^ ]*')).exec(clickedIcon.attr('class'))[0],
        title = clickedIcon.parent().text(),
        newValue = clickedIcon.attr('value'),
        ticketId = icon.parents('.ticket-entry').find('input').val(),
        updatedField = icon.parents("ul.status").length > 0 ? "status" : "user_id";

    var OnTicketUpdateSuccess = function() {
      icon.removeClass().addClass('fa ' + selectedClass).attr('title', title).attr('value', newValue);
      moveTicket
    }

    var updateData = {
      field: updatedField,
      newValue: newValue
    };

    $.ajax({
        url: '/tickets/' + ticketId,
        method: "PATCH",
        data: updateData,
        success: OnTicketUpdateSuccess
    });
  });
});
