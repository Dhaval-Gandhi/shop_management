$('#txt_customer_search').on('keyup', function(){
  $.ajax({
    url: "/orders/customer_search",
    type: 'get',
    dataType: 'script',
    data: {
      search: $('#txt_customer_search').val()
    }
  });
});

$('#txt_item_search').on('keyup', function(){
  $.ajax({
    url: "/orders/item_search",
    type: 'get',
    dataType: 'script',
    data: {
      search: $('#txt_item_search').val()
    }
  });
});

$('.customer_select').on('click', function(){
  var selected_customer = $(this)
  $('#order_customer_id').val(selected_customer.data('id'));
  $('#customer_name').val(selected_customer.data('name'));
});

$('.item_select').on('click', function(){
  var selected_item = $(this)
  var index = $('.item_field').length
  $('#order_item_fields').append('<tr class="item_field"><td><input type="text" name="item_name" id="item_name" value="'+selected_item.data('name')+'" class="form-control" readonly="readonly"></td><td><input class="form-control" type="text" name="order[order_items_attributes]['+index+'][qty]" id="order_order_items_attributes_'+index+'_qty" value="1.0"></td><td><input class="form-control" placeholder="Rate" type="text" name="order[order_items_attributes]['+index+'][rate]" id="order_order_items_attributes_'+index+'_rate" value="'+selected_item.data('rate')+'"></td><td><input autocomplete="off" type="hidden" value="'+selected_item.data('id')+'" name="order[order_items_attributes]['+index+'][item_id]" id="order_order_items_attributes_'+index+'_item_id"><a class="mt-1 btn btn-sm btn-danger remove_item" href="javascript:void(0)">X</a></td></tr>');
  setRemoveItemHandler();
});

function setRemoveItemHandler(){
  $('.remove_item').unbind();
  $('.remove_item').on('click', function(){
    if($(this).siblings("input[class=order_item_destroy]").length > 0){
      $(this).siblings("input[class=order_item_destroy]").val(true);
      $(this).parent().parent().addClass('d-none');
    } else {
      $(this).parent().parent().remove();
    }
  });
}

setRemoveItemHandler();
