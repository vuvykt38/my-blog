// var countSelectedCells = function() {
//   return document.getElementsByClassName("cell selected").length;
// }

// var markAsSelected = function() {
//   var countSelected = countSelectedCells();

//   if (countSelected > 0)
//     return;

//   var newClassName = this.getAttribute('class');
//   if (newClassName.indexOf('selected') == -1) {
//     newClassName += ' selected';
//   }

//   this.setAttribute("class", newClassName);
// };

// var elements = document.getElementsByClassName("cell");
// for (var i = 0; i < elements.length; i++) {
//   elements[i].addEventListener('click', markAsSelected, false);
// }



$(document).ready(function() {

  var PIECES = ['white-king',
                'white-bishop',
                'white-horse',
                'white-rook',
                'white-pawn',
                'black-king',
                'black-queen',
                'black-bishop',
                'black-horse',
                'black-rook',
                'black-pawn'];

  function movePiece(from, to) {
    var fromPiece = $('#' + from).attr("class").split(' ').filter(element => PIECES.indexOf(element) > -1);

    $('#' + from).removeClass(fromPiece);

    // Clear target cell
    var toPiece = $('#' + to).attr("class").split(' ').filter(element => PIECES.indexOf(element) > -1);
    $('#' + to).removeClass(toPiece);


    $('#' + to).addClass(fromPiece);
    console.log('Moving piece from: ' + from + ' to: ' + to);
  }


  $('#game-board .cell').click(function(event) {
    var selectedCell = $('.cell.selected')[0]

    if (selectedCell) {
      $(selectedCell).removeClass('selected');
      movePiece(selectedCell.id, event.target.id );
    } else {
      var selectedCellPiece = $(event.target).attr("class").split(' ').filter(element => PIECES.indexOf(element) > -1);

      if (selectedCellPiece.length == 0) {
        return;
      }
      $(event.target).addClass('selected');
    }



  })
})