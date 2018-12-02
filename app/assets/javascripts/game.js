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
  var GAME_ID = 1;
  var REFRESH_INTERVAL_IN_MILISECONDS = 5000; // 5 seconds

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


  function pullLatestBoardFromServer() {
    let url = '/games/' + GAME_ID + '.json';
    let gameClasses = PIECES.join(' ');

    $.get(url, function( data ) {
      console.log(data);
      drawBoardFromData(data);
    });
  }

  function drawBoardFromData(data) {
    // var board = {"1a":"white-rook","1b":"white-horse","1c":"white-bishop","1e":"white-king","1f":"white-bishop","1g":"white-horse","1h":"white-rook","2a":"white-pawn","2b":"white-pawn","2d":"white-pawn","2e":"white-pawn","2f":"white-pawn","2g":"white-pawn","2h":"white-pawn","4a":"white-queen","4c":"white-pawn","7a":"black-pawn","7b":"black-pawn","7c":"black-pawn","7d":"black-pawn","7e":"black-pawn","7f":"black-pawn","7g":"black-pawn","7h":"black-pawn","8a":"black-rook","8b":"black-horse","8c":"black-bishop","8d":"black-queen","8e":"black-king","8f":"black-bishop","8g":"black-horse","8h":"black-rook"};
    let board = data['board'];

    $('#game-board .cell').removeClass(PIECES.join(' '));

    for (let position in board){
      console.log(position + " -> " + board[position]);
      $('#' + position).addClass(board[position]);
    }
  }

  function sendMovementToServer(from, to) {
    let url = '/games/' + GAME_ID + '/move';

    return $.post(url, { from: from, to: to });
  }

  function movePiece(from, to) {
    console.log('Moving piece from: ' + from + ' to: ' + to);

    sendMovementToServer(from, to).then((data) => {
      console.log('success move');
      let fromPiece = $('#' + from).attr("class").split(' ').filter(element => PIECES.indexOf(element) > -1);

      $('#' + from).removeClass(fromPiece);

      // Clear target cell
      let toPiece = $('#' + to).attr("class").split(' ').filter(element => PIECES.indexOf(element) > -1);
      $('#' + to).removeClass(toPiece);


      $('#' + to).addClass(fromPiece);
    }, (resonse) => {
      console.log('failed move');
    });
  }



  $('#game-board .cell').click(function(event) {
    let selectedCell = $('.cell.selected')[0]

    if (selectedCell) {
      $(selectedCell).removeClass('selected');
      movePiece(selectedCell.id, event.target.id );
    } else {
      let selectedCellPiece = $(event.target).attr("class").split(' ').filter(element => PIECES.indexOf(element) > -1);

      if (selectedCellPiece.length == 0) {
        return;
      }
      $(event.target).addClass('selected');
    }
  })

  pullLatestBoardFromServer();
  setInterval(function(){
    pullLatestBoardFromServer();
  }, REFRESH_INTERVAL_IN_MILISECONDS);
})