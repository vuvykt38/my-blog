class Game < ApplicationRecord
  INITIAL_BOARD = {
    '1a': 'white-rook',
    '1b': 'white-horse',
    '1c': 'white-bishop',
    '1d': 'white-queen',
    '1e': 'white-king',
    '1f': 'white-bishop',
    '1g': 'white-horse',
    '1h': 'white-rook',

    '2a': 'white-pawn',
    '2b': 'white-pawn',
    '2c': 'white-pawn',
    '2d': 'white-pawn',
    '2e': 'white-pawn',
    '2f': 'white-pawn',
    '2g': 'white-pawn',
    '2h': 'white-pawn',

    '7a': 'black-pawn',
    '7b': 'black-pawn',
    '7c': 'black-pawn',
    '7d': 'black-pawn',
    '7e': 'black-pawn',
    '7f': 'black-pawn',
    '7g': 'black-pawn',
    '7h': 'black-pawn',
    '8a': 'black-rook',
    '8b': 'black-horse',
    '8c': 'black-bishop',
    '8d': 'black-queen',
    '8e': 'black-king',
    '8f': 'black-bishop',
    '8g': 'black-horse',
    '8h': 'black-rook'
  }.freeze
  scope :visible, -> { where(public: true)}
  belongs_to :black_player, class_name: 'User', required: false
  belongs_to :white_player, class_name: 'User', required: false

  before_validation :set_default_move_timeout, on: :create
  before_validation :set_default_board, on: :create

  validates_presence_of :status, :player_turn, :board, :move_timeout
  validate :one_player_needed

  def join!(user)
    if !black_player.present?
      update(black_player: user)
    elsif !white_player.present?
      update(white_player: user)
    else
      errors.add(:player, 'The game already has two players!')
      false
    end
  end

  def move(from, to)
    new_board = board
    new_board[to] = new_board[from]
    new_board.delete(from)
    update(board: new_board)
  end

  def self.new_game_for(user, params)
    player = ['black_player', 'white_player'].sample
    Game.new(params.merge(player => user, player_turn: player))
  end

  private

  def one_player_needed
    errors.add(:player, 'One player needed!') if !black_player.present? && !white_player.present?
  end

  def set_default_move_timeout
    self.move_timeout = 0 # forever
  end

  def set_default_board
    self.status = 'ongoing'
    self.board = INITIAL_BOARD
  end
end
