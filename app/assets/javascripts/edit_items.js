$(function(){
  function buildHTML(count) {
    var html = `<div class="item-image" id="preview-box__${count}">
                  <img src="" height="170" width="170" alt="preview" >
                  <div class="item-image__operation">
                    <div class="item-image__operation--edit__delete__hidden" id="delete_btn_${count}">削除</div>
                    </div>
                  </div>
                </div>`
    return html;
  }
  //商品編集ページへ遷移した際のアクション
  if (window.location.href.match(/\/items\/\d+\/edit/)){
    //登録済み画像のプレビューの表示
    var prevContent = $('.item-image').prev();
    labelWidth = (770 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
    $('.label-content').css('width', labelWidth);
    //プレビューにidを追加
    $('.item-image').each(function(index, box){
      $(box).attr('id', `preview-box__${index}`);
    })
    //削除ボタンにidを追加
    $('.item-image__operation--edit__delete__hidden').each(function(index, box){
      $(box).attr('id', `delete_btn_${index}`);
    })
    var count = $('.item-image').length;
    //プレビューが10枚あるときは投稿ボックスを消す
    if (count == 10) {
      $('.label-content').hide();
    }
  }
  // 投稿ボックスの横幅調整
  function setLabel(){
    var prevContent = $('.label-content').prev();
    labelWidth = (620 - $(prevContent).css('width'));
    $('.label-content').css('width', labelWidth);
  }
  // 10枚登録されていた場合にドロップボックスを消す
  $(document).ready(function(){
    var image_num = $('.item-image').length
    if (image_num==10){
      $('.label-content').css('display', 'none')
    }
  });

  // 画像をアップロードする際のアクション
  $(document).on('change', '.hidden-field', function(){
    setLabel();
    var id = $(this).attr('id').replace(/[^0-9]/g, '');

    $('.label-box').attr({id: `label-box--${id}`, for: `item_item_images_attributes_${id}_item_image`});
    var file = this.files[0];
    var reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = function(){
      var image = this.result;
      if ($(`#preview-box__${id}`).length == 0){
        var count = $('.item-image').length;
        var html = buildHTML(id);
        var prevContent = $('.label-content').prev();
        $(prevContent).append(html);
      }
      // 画像を追加
      $(`#preview-box__${id} img`).attr('src', `${image}`);
      var count = $('.item-image').length;
      console.log(count);
      // 画像が10個会ったら投稿ボックスを消す
      if (count == 10){
        $('.label-content').hide();
      }
      if ($(`#item_item_images_attributes_${id}__destroy`)){
        $(`#item_item_images_attributes_${id}__destroy`).prop('checked', false);
      }
      setLabel();
      if (count < 10){
        $('.label-box').attr({id: `label-box--${count}`, for: `item_item_images_attributes_${count}_item_image`});
      }
    }
  });

  $(document).on('click', '.item-image__operation--edit__delete__hidden', function() {
    var count = $('.item-image').length;
    setLabel(count);
    var id = $(this).attr('id').replace(/[^0-9]/g, '');
    $(`#preview-box__${id}`).remove();
    //削除用チェックボックスの有無を判定
    if ($(`#item_item_images_attributes_${id}__destroy`).length == 0) {
      $(`#item_item_images_attributes_${id}_item_image`).val("");
      var count = $('.item-image').length;
      //10個めが消されたら投稿ボックスを表示
      if (count == 9) {
        $('.label-content').show();
      }
      setLabel(count);
      if(id < 10){
        $('.label-box').attr({id: `label-box--${id}`,for: `item_item_images_attributes_${id}_item_image`});
      }
    } else {
      //投稿編集時
      $(`#item_item_images_attributes_${id}__destroy`).prop('checked',true);
      //10個めが消されたら投稿ボックスを表示
      setLabel();
      //ラベルのidとforの値を変更
      if(id < 10){
        $('.label-box').attr({id: `label-box--${id}`,for: `item_item_images_attributes_${id}_item_image`});
      }
    }
  });
});
