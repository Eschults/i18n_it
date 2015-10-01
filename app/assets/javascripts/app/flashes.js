function notices() {
  if($('.alert').length > 0 ) {
    setTimeout(function(){
      $('.alert').slideUp()
    }, 3000)
  }
}
$(document).ready(function() {
  notices()
})