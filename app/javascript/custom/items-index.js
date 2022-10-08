$('#btn_search').on('click', function(){
  $.ajax({
    url: "items",
    type: 'get',
    dataType: 'script',
    data: {
      search: $('#txt_search').val()
    }
  });
});