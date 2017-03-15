var slyData;
function init_loadImage(domId){
	 var $frame = $(domId);
     var $wrap = $frame.parent();
     if(slyData){
    	 $frame.sly('destroy')
     }
     // Call Sly on frame
     slyData = $frame.sly({
         horizontal: 1,
         itemNav: 'forceCentered',
         smart: 1,
         activateMiddle: 1,
         mouseDragging: 1,
         touchDragging: 1,
         releaseSwing: 1,
         startAt: 0,
         scrollBar: $wrap.find('.scrollbar'),
         scrollBy: 1,
         speed: 300,
         elasticBounds: 1,
         easing: 'easeOutExpo',
         dragHandle: 1,
         dynamicHandle: 1,
         clickBar: 1,

         // Buttons
         prev: $wrap.find('.prev'),
         next: $wrap.find('.next')
     });
}

function init_loadImage_2(domId){
	var $frame = $(domId);
    var $wrap = $frame.parent();

    // Call Sly on frame
    $frame.sly({
        horizontal: 1,
        itemNav: 'forceCentered',
        smart: 1,
        activateMiddle: 1,
        activateOn: 'click',
        mouseDragging: 1,
        touchDragging: 1,
        releaseSwing: 1,
        startAt: 0,
        scrollBar: $wrap.find('.scrollbar'),
        scrollBy: 1,
        speed: 300,
        elasticBounds: 1,
        easing: 'easeOutExpo',
        dragHandle: 1,
        dynamicHandle: 1,
        clickBar: 1,

        // Buttons
        prev: $wrap.find('.prev'),
        next: $wrap.find('.next')
    });
}
(function () {
    var $frame = $('#babyframe');
    var $wrap = $frame.parent();

    console.log($frame);
    // Call Sly on frame
    $frame.sly({
        horizontal: 1,
        itemNav: 'forceCentered',
        smart: 1,
        activateMiddle: 1,
        activateOn: 'click',
        mouseDragging: 1,
        touchDragging: 1,
        releaseSwing: 1,
        startAt: 0,
        scrollBar: $wrap.find('.scrollbar'),
        scrollBy: 1,
        speed: 300,
        elasticBounds: 1,
        easing: 'easeOutExpo',
        dragHandle: 1,
        dynamicHandle: 1,
        clickBar: 1,

        // Buttons
        prev: $wrap.find('.baby_left'),
        next: $wrap.find('.baby_right')
    });
}());
