
var slideIndex = 1;

function plusSlides(n) {
  showSlides(slideIndex += n);
}
function showSlides(n) {
  var i;
  var slides = $(".mySlides");
  
  if (n > slides.length) {slideIndex = 1}    
  if (n < 1) {slideIndex = slides.length}
  
  $(".mySlides").removeClass('show');
  
  if(slides[slideIndex-1]){
    $(".mySlides").eq(slideIndex-1).addClass('show');
  }
}

window['drumEffect'] = ()=> {
  Hammer.plugins.fakeMultitouch();
  $("select").drum();
  showSlides(slideIndex);
};