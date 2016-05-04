class Playfield
  attr_accessor :current_cards

  def initialize
    @current_cards = nil
  end

  def update(cards)
    @current_cards = cards
  end

  def clear
    @current_cards = nil
  end
end