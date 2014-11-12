$(function() {
  $(".dropdown-menu").on('click', 'li a', function(){
    var clickedIcon = $(this).find('i'),
        icon = $(this).parents(">a>i"),
        selectedClass = (new RegExp('fa-[^ ]*')).exec(clickedIcon.attr('class'))[0],
        title = clickedIcon.parent().text(),
        newValue = clickedIcon.attr('value'),
        ticketId = icon.parents('.ticket-entry').find('input').val();

    var OnTicketUpdateSuccess = function() {
      icon.removeClass().addClass('fa ' + selectedClass).attr('title', title).attr('value', newValue);
    }

    var updateData = {};

    updateData[icon.parents("ul.status").length > 0 ? "status" : "user_id"] = newValue;

    $.ajax({
        url: '/tickets/' + ticketId,
        method: "PATCH",
        data: updateData,
        success: OnTicketUpdateSuccess
    });
  });
});
