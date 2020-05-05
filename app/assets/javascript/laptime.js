$(function() {
  // 合計タイム計算
  $('.sector').change(function() {
    let parent = $(this).closest('tr');
    let sec1 = $(parent).find('.sec1').val();
    let sec2 = $(parent).find('.sec2').val();
    let sec3 = $(parent).find('.sec3').val();

    let total = parseFloat(sec1) + parseFloat(sec2) + parseFloat(sec3);
    total = Math.floor( total * Math.pow( 10, 3 ) ) / Math.pow( 10, 3 ) ;
    $(parent).find('.total').val(total)
    console.log('hoge');
  });
});
