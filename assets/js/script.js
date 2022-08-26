$(document).ready(function(){

  $('#account').parallax({imageSrc: 'images/account_img.jpg'});
  $('#my-performance').parallax({imageSrc: 'images/my-performance.jpg'});
  $('#certificate').parallax({imageSrc: 'images/cartificate.jpg'});
    $('.search-panel').each( function() {
      var to = $(this).data('search').toString();
      var text = $(this).find('[data-search="' + to + '"]').html();
      $(this).find('button span.search_by').html(text);
    });
    
    $('.search-panel li a').on('click', function(e){
      var sp = $(this).closest('.search-panel');
      var to = $(this).html();
      var text = $(this).html();
      sp.data('search', to);
      console.log(sp.find('.search_by'));
      sp.find('button span.search_by').html(text);
    });

    $('.filterMenu .dmenu').hover(function () {
        $(this).find('.sm-menu').first().stop(true, true).slideDown(150);
    }, function () {
        $(this).find('.sm-menu').first().stop(true, true).slideUp(105)
    });

    $('.profile_toggle').click(function() {
        $('.profile_menu').toggleClass('profile_width100');
      });
      $('.student_prof_cross').click(function() {
        $('.profile_menu').removeClass('profile_width100');
      });
    
    $(".showBtn").click(function(){
        $(".resultDisplay").show();
      });
    $(".filterSeach").click(function(){
        $(".filterResultBox").slideDown("slow");
    });
    $(".filterCloseBtn").click(function(){
        $(".filterResultBox").slideUp("slow");
      });
    
     $(".navbarList li a").click(function() {
        $(".sidenav").removeClass("width100");
     });

     $(".addVideo").click(function(){
        $(".cartLeftBox tbody").append('<tr><td><img class="img-fluid itemImg" src="images/product1.png"></td><td><h5>Finance for the Real World -  <br>Corporate Finance 101</h5>By Ben Jacobs <br>Media: video <img class="img-fluid" src="images/video1.png"><br>Duration (3h 45min)</td><td class="usdtext"><span class="td16">20 USD</span><br><span class="td12">add to Wishlist </span><i class="far fa-heart"></i></td><td><img class="closecard" src="images/close-circle.png" /></td></tr>');
     });

    $(".addpdf").click(function(){
      $(".cartLeftBox tbody").append('<tr><td><img class="img-fluid itemImg" src="images/product1.png"></td><td><h5>Finance for the Real World -  <br>Corporate Finance 101</h5>By Ben Jacobs <br>Media: PDF <img class="img-fluid" src="images/pdf.png"><br>Duration (3h 45min)</td><td class="usdtext"><span class="td16">20 USD</span><br><span class="td12">add to Wishlist </span><i class="far fa-heart"></i></td><td><img class="closecard" src="images/close-circle.png" /></td></tr>');
    });
    $(".addScrom").click(function(){
      $(".cartLeftBox tbody").append('<tr><td><img class="img-fluid itemImg" src="images/product1.png"></td><td><h5>Finance for the Real World -  <br>Corporate Finance 101</h5>By Ben Jacobs <br>Media: SCROM <img class="img-fluid" src="images/scrom.png"><br>Duration (3h 45min)</td><td class="usdtext"><span class="td16">20 USD</span><br><span class="td12">add to Wishlist </span><i class="far fa-heart"></i></td><td><img class="closecard" src="images/close-circle.png" /></td></tr>');
    });
    $(".closecard").click(function(){
      $(this).parent().find("tr").remove();
    });

        // Detect request animation frame
    var scroll = window.requestAnimationFrame ||
    // IE Fallback
    function(callback){ window.setTimeout(callback, 2000/60)};
    var elementsToShow = document.querySelectorAll('.show-on-scroll'); 

    function loop() {
    Array.prototype.forEach.call(elementsToShow, function(element){
    if (isElementInViewport(element)) {
    element.classList.add('is-visible');
    } else {
    element.classList.remove('is-visible');
    }
    });
    scroll(loop);
    }
    // Call the loop for the first time
    loop();

    
    var $body = $('body');
    var $box = $('.box');
    for (var i = 0; i < 20; i++) {
      $box.clone().appendTo($body);
    }
  
   
  
});

$(function() {
	var $a = $(".tabs li");
	$a.click(function() {
		$a.removeClass("active");
		$(this).addClass("active");
	});
});
$(window).scroll(function() {    
    var scroll = $(window).scrollTop();

    if (scroll >= 50) {
        $(".header ").addClass("darkHeader");
    } else {
        $(".header ").removeClass("darkHeader");
    }
});

function AddReadMore() {
    var carLmt = 200;
    var readMoreTxt = " <i class='fas fa-plus'></i>";
    var readLessTxt = " <i class='fas fa-minus'></i>";
 
 
    //Traverse all selectors with this class and manupulate HTML part to show Read More
    $(".addReadMore").each(function() {
        if ($(this).find(".firstSec").length)
            return;
 
        var allstr = $(this).text();
        if (allstr.length > carLmt) {
            var firstSet = allstr.substring(0, carLmt);
            var secdHalf = allstr.substring(carLmt, allstr.length);
            var strtoadd = firstSet + "<span class='SecSec'>" + secdHalf + "</span><span class='readMore'  title='Click to Show More'>" + readMoreTxt + "</span><span class='readLess' title='Click to Show Less'>" + readLessTxt + "</span>";
            $(this).html(strtoadd);
        }
 
    });
    //Read More and Read Less Click Event binding
    $(document).on("click", ".readMore,.readLess", function() {
        $(this).closest(".addReadMore").toggleClass("showlesscontent showmorecontent");
    });
}
$(function() {
    //Calling function after Page Load
    AddReadMore();
});


 // Helper function for add element box list in WOW
 WOW.prototype.addBox = function(element) {
  this.boxes.push(element);
};


window['scrollEffect'] = function () {

  var wow = new WOW();
    wow.init();

  var scrollTransfer = window.requestAnimationFrame ||
  // IE Fallback
  function(callback1){ window.setTimeout(callback1, 1000/60)};
  
  scrollTransfer(() => {
    $('.imgTransfer').each(function(){
    
      if (isElementInViewport(this)) {
        this.classList.add('is-visible');
      } else {
        this.classList.remove('is-visible');
      }
    });
  });
  
  $('.wow').on('scrollSpy:exit', function() {
    $(this).css({
      'visibility': 'hidden',
      'animation-name': 'none'
    }).removeClass('animated');
    wow.addBox(this);
  }).scrollSpy();
  

};

    // Helper function from: http://stackoverflow.com/a/7557433/274826
function isElementInViewport(el) {
    // special bonus for those using jQuery
    if (typeof window.jQuery === "function" && el instanceof window.jQuery) {
      el = el[0];
    }
    if(!el) return false;
    var rect = el.getBoundingClientRect();
    return (
      (rect.top <= 10
      && rect.bottom >= 0)
      ||
      (rect.bottom >= (window.innerHeight || document.documentElement.clientHeight) &&
      rect.top <= (window.innerHeight || document.documentElement.clientHeight))
      ||
      (rect.top >= 0 &&
      rect.bottom <= (window.innerHeight || document.documentElement.clientHeight))
    );
};
