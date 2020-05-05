$(function() {

  $fileField = '';

  if ($('body').hasClass('user')) {
    $fileField = $('#user_img');
  } else if ($('body').hasClass('car')) {
    $fileField = $('#car_img');
  } else if ($('body').hasClass('circuit')) {
    $fileField = $('#circuit_img');;
  }

  console.log($fileField)

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
          width: "100%",
          class: "preview",
          title: file.name
        }));
      };
    })(file);
    reader.readAsDataURL(file);
  });
});
