$('.sub-bucket-nav-link').on('click', function() {
  $('.sub-bucket-active').removeClass('sub-bucket-active')
  $(this).addClass('sub-bucket-active')
  var id = $(this).attr('id')
  $('.edit-sub-bucket').hide();
  $('#sub_bucket_' + id).show();
})

$('.js-target').on('click', function(event) {
  event.preventDefault()
  var id = $(this).attr('id').slice($(this).attr('id').lastIndexOf('_') + 1, $(this).attr('id').length)
  $('#sub_bucket_id').val(id)
  $('form').submit()
})

$('.cross-languages-bucket-schemas input').on('change', function() {
  var id = $(this).attr('id')
  var slicedId = id.slice(0, id.lastIndexOf('_'))
  $('input[id^="' + slicedId + '"]').val($(this).val())
})