$(function(){
  $(".categories").hover(function() {
    $("ul.categories__parent").toggle();
  });
  $(".categories li ul").hide();
  $(".categories__child li").hover(function() {
    $(this).children('.categories__grandchild').css('display', 'block')
  }, function() {
    $(this).children('.categories__grandchild').css('display', 'none')
  });
  $(".categories li").hover(function() {
      $(">ul:not(:animated)", this).stop(true, true).slideDown("fast");
      $(">カテゴリー", this).addClass("active");
  }, function() {
      $(">ul:not(:animated)", this).stop(true, true).slideUp("fast");
      $(">カテゴリー", this).removeClass("active");
      
  });
});
