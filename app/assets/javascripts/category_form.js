$(function(){
  // カテゴリーセレクトボックスのオプションを作成
  function appendOption(category){
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  // 子カテゴリーの表示作成
  function appendChildrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<div class='select--wrap' id= 'category__box--children'>
                        <select class="select--default__category1" id="child_form" name="item[category_id]">
                          <option value="---" data-category="---">選択してください</option>
                          ${insertHTML}
                        <select>
                        <i class='fas fa-chevron-down'></i>
                      </div>`;
    $('.sell__container__main__detail__box__category').append(childSelectHtml);
  }
  // 孫カテゴリーの表示作成
  function appendGrandchildrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class='select--wrap' id= 'category__box--grandchildren'>
                              <select class="select--wrap__category2" id="grandchild_form" name="item[category_id]">
                                <option value="---" data-category="---">選択してください</option>
                                ${insertHTML}
                              </select>
                              <i class='fas fa-chevron-down'></i>
                            </div>`;
    $('.sell__container__main__detail__box__category').append(grandchildSelectHtml);
  }
  // 子要素のアクション
  $('#parent_form').on('change', function(){
    var parentValue = document.getElementById('parent_form').value; //選択された親カテゴリーの名前を取得
    if (parentValue != "選択してください"){ //親カテゴリーが初期値でないことを確認
      $('#category__box--children').remove(); //親が変更された時、子以下を削除する
      $('#category__box--grandchildren').remove();
      $.ajax({
        url: '/items/search_child',
        type: 'GET',
        data: {
          parent_id: parentValue
        },
        dataType: 'json'
      })
      .done(function(children){
        $('#category__box--children').remove(); //親が変更された時、子以下を削除する
        $('#category__box--grandchildren').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChildrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#category__box--children').remove(); //親カテゴリーが初期値になった時、子以下を削除する
      $('#category__box--grandchildren').remove();
    }
  });
  // 孫要素のアクション
  $('.sell__container__main__detail__box__category').on('change', '#child_form', function(){
    var childValue = $('#child_form option:selected').data('category'); //選択された子カテゴリーのidを取得
    if (childValue != "選択してください"){ //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/items/search_grandchild',
        type: 'GET',
        data: {
          child_id: childValue
        },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0){
          $('#category__box--grandchildren').remove();
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandchildrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#category__box--children').remove(); 
      $('#category__box--grandchildren').remove();
    }
  });
});
