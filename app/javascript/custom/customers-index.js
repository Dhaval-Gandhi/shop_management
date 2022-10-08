$('#btn_search').on('click', function(){
  $.ajax({
    url: "customers",
    type: 'get',
    dataType: 'script',
    data: {
      search: $('#txt_search').val()
    }
  });
});