window.onload = function(){

  //子カテゴリー、孫カテゴリーのセレクトボックスの選択肢
  function appendOption(category){
    //value="${category.name}"については、ストロングパラメーターでの値の取り方によってcategory.idの場合もあると思います。
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }

  //子カテゴリーのビュー作成
  function appendChildrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<div class='listing-select-wrapper__added' id= 'children_wrapper'>
                        <div class='listing-select-wrapper__box'>
                          <select class="listing-select-wrapper__box--select" id="child_category" name="category_id">
                            <option value="---" data-category="---">---</option>
                            ${insertHTML}
                          <select>
                        </div>
                      </div>`;
    $('.pulldown.hobby_input__body__category__children').append(childSelectHtml);
  }

 //孫カテゴリーのビュー作成
  function appendGrandchildrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class='listing-select-wrapper__added' id= 'grandchildren_wrapper'>
                              <div class='listing-select-wrapper__box'>
                                <select class="listing-select-wrapper__box--select" id="grandchild_category" name="category_id">
                                  <option value="---" data-category="---">---</option>
                                  ${insertHTML}
                                </select>
                              </div>
                            </div>`;
    $('.pulldown.hobby_input__body__category__grandchildren').append(grandchildSelectHtml);
  }

  //親カテゴリーが選択された時の処理（子カテゴリーの表示）
  jQuery('#parent_category').on('change', function() {
    //選択された親カテゴリーの値を取得
    var parentCategory = document.getElementById('parent_category').value;
    //選択された親カテゴリーが"---"（初期設定）のままだとfalse、変わっているとtrue
    if (parentCategory != "---"){
      $.ajax({
        url: 'get_category_children',
        type: 'GET',
        //コントローラーに飛ばす値です。
        data: { parent_name: parentCategory },
        dataType: 'json'
      })
      .done(function(children){
        //まず、既に表示されている子、孫カテゴリーを削除
        $('#children_wrapper').empty();
        $('#grandchildren_wrapper').empty();
        //insertHTMLという変数にカテゴリーのセレクトボックスの選択肢を入れる。（一番最初の段落で設けた変数）
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        //2段落目で設定した子カテゴリーのビューの呼び出し
        appendChildrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children_wrapper').empty();
      $('#grandchildren_wrapper').empty();
    }
  });

  //子カテゴリーが選択された時の処理（孫カテゴリーの表示）
  jQuery('.pulldown.hobby_input__body__category__children').on('change', function() {
    var childId = $('#child_category option:selected').data('category');
    if (childId != "---"){
      $.ajax({
        url: 'get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if(grandchildren.length != 0) {
          $('#grandchildren_wrapper').empty();
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
      $('#grandchildren_wrapper').empty();
    }
  });
};