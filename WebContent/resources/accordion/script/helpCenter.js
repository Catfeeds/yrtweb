$(function(){    
   $("li").click(function(){
     $(".foldContent").stop(true).slideUp();
     $(this).children(".foldContent").stop(true).slideDown();
     
     })
})