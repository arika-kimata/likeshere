$(document).on('click', '.comment__bottom__delete', function(){
  var comment_data_id = $(this).parent().parent().data("message-id")
  var url = "/events/" + gon.event.id + "/set_lists/" + gon.set_list.id + "/messages/" + message_data_id
  $.ajax({
    url: url,
    type: "DELETE",
    data: message_data_id,
    datatype: "json"
  })
  
  .done(function(message_id){
    $('[data-message-id = '+ message_id + ']').remove();
  })
})