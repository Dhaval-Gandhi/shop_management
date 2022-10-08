$('#txt_customer_search').on('keyup', function(){
  $.ajax({
    url: "customer_search",
    type: 'get',
    dataType: 'script',
    data: {
      search: $('#txt_customer_search').val()
    }
  });
});

$('#txt_item_search').on('keyup', function(){
  $.ajax({
    url: "item_search",
    type: 'get',
    dataType: 'script',
    data: {
      search: $('#txt_item_search').val()
    }
  });
});