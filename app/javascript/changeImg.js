$(function() {
  if ($('.thumbnail').length){
    imgSize();
  }

  $fileField = '';

  if ($('body').hasClass('user')) {
    $fileField = $('#user_img');
  } else if ($('body').hasClass('car')) {
    $fileField = $('#car_img');
  } else if ($('body').hasClass('circuit')) {
    $fileField = $('#circuit_img');;
  }

  // 選択された画像を取得し表示
  $($fileField).on('change', $fileField, function(e) {
    file = e.target.files[0]
    reader = new FileReader(),
    $preview = $("#img");

    reader.onload = (function(file) {
      return function(e) {
        $preview.empty();
        $preview.append($('<img>').attr({
          src: e.target.result,
        }));
      };
    })(file);
    reader.readAsDataURL(file);
    setTimeout(imgSize, 100);
  });
});

var imgSize = function() {
  $('.thumbnail img').each(function () {

    var img = $(this),
      imgH = img.innerHeight(),
      imgW = img.innerWidth();

    if (imgH >= imgW) {
      img.css({'height':'auto','width':'100%'});
    } else if (imgH <= imgW) {
      img.css({'height':'100%','width':'auto'});
    }
  });
}
