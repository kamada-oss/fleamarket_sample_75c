$(function() {
  $(".categories").hover(function() {
  $("ul.categories__parent").toggle();
  console.log("Hello world");
  });
  $(".categories li ul").hide();
  $(".categories li").hover(function() {
      $(">ul:not(:animated)", this).stop(true, true).slideDown("fast");
      $(">カテゴリー", this).addClass("active");
  }, function() {
      $(">ul:not(:animated)", this).stop(true, true).slideUp("fast");
      $(">カテゴリー", this).removeClass("active");
  });
});