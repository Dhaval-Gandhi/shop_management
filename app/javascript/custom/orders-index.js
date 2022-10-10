$('#btn_search').on('click', function(){
  $.ajax({
    url: "orders",
    type: 'get',
    dataType: 'script',
    data: {
      search: $('#txt_search').val()
    }
  });
});