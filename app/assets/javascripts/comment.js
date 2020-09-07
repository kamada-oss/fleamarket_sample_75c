$(function(){
  function buildHTML(comment){
    var text = comment.text ? `${comment.text}` : "";
    var text = text.replace(/\n|\r\n|\r/g, '<br>');
    if (comment.user_id == comment.item_user) {
      let html =
      `<div class='main__show__contents__content__comment-box__list__box' id='box_comment_${comment.id}'>
        <div class='main__show__contents__content__comment-box__list__box__name'>
          <div class="main__show__contents__content__comment-box__list__box__name__saler">
            出品者
          </div>
          <div class="main__show__contents__content__comment-box__list__box__name__delete">
            <a class="main__show__contents__content__comment-box__list__box__name__delete__btn" data-remote="true" rel="nofollow" data-method="delete" href="/items/${comment.item}/comments/${comment.id}">
              削除する
            </a>
          </div>
        </div>
        <div class='main__show__contents__content__comment-box__list__box__message'>
          <div class="main__show__contents__content__comment-box__list__box__message__text">
            <p>${text}</p>
          </div>
          <div class="main__show__contents__content__comment-box__list__box__message__date">
            ${comment.created_at}
          </div>
        </div>
      </div>`
      return html;
    } else {
      let html =
      `<div class='main__show__contents__content__comment-box__list__box'>
        <div class='main__show__contents__content__comment-box__list__box__name'>
          <div class='main__show__contents__content__comment-box__list__box__name__nickname'>
            ${comment.user_name}
          </div>
        </div>
        <div class='main__show__contents__content__comment-box__list__box__message'>
          <div class="main__show__contents__content__comment-box__list__box__message__text">
            <p>${text}</p>
          </div>
          <div class="main__show__contents__content__comment-box__list__box__message__date">
            ${comment.created_at}
          </div>
        </div>
      </div>`
      return html;
    }
  }
  $('#main__show__contents__content__comment-box__form').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data) {
      var html = buildHTML(data);
      $('.main__show__contents__content__comment-box__list').append(html);
      $('.main__show__contents__content__comment-box__form__textarea').val('');
      $('.main__show__contents__content__comment-box__form__btn').prop('disabled', false);
    })
    .fail(function(){
      alert('コメントを入力してください');
    });
  });
})