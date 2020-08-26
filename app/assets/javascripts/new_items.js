$(function(){
  //DataTransferオブジェクトで、データを格納する箱を作る
  var dataBox = new DataTransfer();
  //querySelectorでfile_fieldを取得
  var file_field = document.getElementById('img-file')
  //fileが選択された時に発火するイベント
  $('#append-js').on('change','#img-file',function(){
    $.each(this.files, function(i, file){
      //FileReaderのreadAsDataURLで指定したFileオブジェクトを読み込む
      var fileReader = new FileReader();
      //DataTransferオブジェクトに対して、fileを追加
      dataBox.items.add(file)
      var num = $('.item-image').length + 1 + i
      var image_no = $('.item-image').length + i
      fileReader.readAsDataURL(file);
      //画像が10枚になったら超えたらドロップボックスを削除する
      if (num == 10){
        $('#image-box__container').css('display', 'none')   
      }
      //読み込みが完了すると、srcにfileのURLを格納
      fileReader.onloadend = function() {
        var src = fileReader.result
        var html= `<div class='item-image' data-image="${file.name}" data-index="${image_no}">
                    <div class='item-image__content'>
                      <div class='item-image__content--icon'>
                        <img src=${src} width="170" height="170" >
                      </div>
                    </div>
                    <div class='item-image__operation'>
                      <div class='item-image__operation--delete'>削除</div>
                    </div>
                  </div>`
        const buildFileField = (num)=> {
          const html = `<div  class="js-file_group" data-index="${num}">
                          <input class="js-file" type="file"
                          name="item[item_images_attributes][${num}][item_image]"
                          id="img-file" data-index="${num}">
                        </div>`;
          return html;
        }
        $('.js-file').removeAttr('id');
        //image_box__container要素の前にhtmlを差し込む
        $('.input-box__image').before(html);
        // $('#image-box__container').before(buildFileField(num))
        $('#append-js').append(buildFileField(num));
      }; 
      //image-box__containerのクラスを変更し、CSSでドロップボックスの大きさを変えてやる。
      $('#image-box__container').attr('class', `item-num-${num}`)
    });
  });
  //削除ボタンをクリックすると発火するイベント
  $(document).on("click", '.item-image__operation--delete', function(){
    //削除を押されたプレビュー要素を取得
    var target_image = $(this).parent().parent();
    //削除を押されたプレビューimageのfile名を取得
    var target_index = $(target_image).data('index');
    var target_file = $('[data-index="'+target_index+'"].js-file');
    //プレビューを削除
    target_image.remove()
    target_file.remove()
    //image-box__containerクラスをもつdivタグのクラスを削除のたびに変更
    var num = $('.item-image').length
    $('#image-box__container').show()
    $('#image-box__container').attr('class', `item-num-${num}`)
  })
  // 削除ボタンを押された時の記述
  var dropArea = $(".item-num-0");
  dropArea.on("dragenter", function(e){
    e.stopPropagation();
    e.preventDefault();
  });

  //ドラッグアンドドロップの記述
  //ドラッグした要素がドロップターゲットの上にある時にイベントが発火
  dropArea.on("dragover", function(e){
    e.stopPropagation();
    e.preventDefault();
    //ドロップエリアに影がつく
    // $(this).children('#image-box__container').css({'border': '1px solid rgb(204, 204, 204)','box-shadow': '0px 0px 4px'});
    $(this).css({'border': '1px solid rgb(204, 204, 204)','box-shadow': '0px 0px 4px'});
  });
  dropArea.on("dragleave", function(e){
    e.preventDefault();
    e.preventDefault();
    //ドロップエリアの影が消える
    $(this).children.css({'border': '1px dashed rgb(204, 204, 204)','box-shadow': '0px 0px 0px'})
  },false);
  //loadイベント発生時に発火するイベント
  window.onload = function(e){
    e.preventDefault();
    //ドラッグした要素がドロップターゲットから離れた時に発火するイベント
    dropArea[0].addEventListener("dragleave", function(e){
      e.stopPropagation()
      e.preventDefault();
    //ドロップエリアの影が消える
      $(this).css({'border': '1px dashed rgb(204, 204, 204)','box-shadow': '0px 0px 0px'})
    },false);
    //ドラッグした要素をドロップした時に発火するイベント
    dropArea[0].addEventListener("drop", function(e) {
      e.stopPropagation()
      e.preventDefault();
      $(this).css({'border': '1px dashed rgb(204, 204, 204)','box-shadow': '0px 0px 0px'}),false;
      var files = e.dataTransfer.files;
      $("#img-file")[0].files = files;
      //ドラッグアンドドロップで取得したデータについて、プレビューを表示
      $.each(files, function(i,file){
        //アップロードされた画像を元に新しくfilereaderオブジェクトを生成
        var fileReader = new FileReader();
        //dataTransferオブジェクトに値を追加
        dataBox.items.add(file)
        //lengthで要素の数を取得
        var num = $('.item-image').length + i + 1
        var image_no = $('.item-image').length + i
        //指定されたファイルを読み込む
        fileReader.readAsDataURL(file);
        // 10枚プレビューを出したらドロップボックスが消える
        if (num==10){
          $('#image-box__container').css('display', 'none')
        }
        //image fileがロードされた時に発火するイベント
        fileReader.onload = function() {
          //変数srcにresultで取得したfileの内容を代入
          var src = fileReader.result
          var html= `<div class='item-image' data-image="${file.name}" data-index="${image_no}">
                    <div class=' item-image__content'>
                      <div class='item-image__content--icon'>
                        <img src=${src} width="188" height="180" >
                      </div>
                    </div>
                    <div class='item-image__operation'>
                      <div class='item-image__operation--delete'>削除</div>
                    </div>
                  </div>`
          const buildFileField = (num)=> {
            const html = `<div  class="js-file_group" data-index="${num}">
                            <input class="js-file" type="file"
                            name="item[item_images_attributes][${num}][item_image]"
                            id="img-file"
                            data-index="${num}">
                          </div>`;
            return html;
          }
        $('.js-file').removeAttr('id');
        //image-box__containerの前にhtmlオブジェクトを追加
        $('.input-box__image').before(html);
        $('#append-js').append(buildFileField(num));
        };
        //image-box__containerにitem-num-(変数)という名前のクラスを追加する
        $('#image-box__container').attr('class', `item-num-${num}`)
      })
    })
  }
    // 入力場所以外にdropした時の挙動をキャンセル
    $(document).on("dragenter", function(e){
      e.stopPropagation();
      e.preventDefault();
    });
    $(document).on("dragover", function(e){
      e.stopPropagation();
      e.preventDefault();
    });
    $(document).on("drop", function(e){
      e.stopPropagation();
      e.preventDefault();
    });
});