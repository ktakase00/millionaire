class Player
  attr_accessor :play_order, :name, :cards, :is_passed

  def initialize
    @is_passed = false
  end

  # ダイヤの3を持っているか否か
  def has_dia_three
    @cards.each do |card|
      return true if card.is_dia_three
    end
    return false
  end

  # プレイの順番
  def set_play_order(play_order)
    @play_order = play_order
    # 名前をつける
    @name = "Player " + play_order.to_s
  end

  # 自分の番が来たら呼ばれる
  # 上がったらtrue, そうでなければfalseを返す
  def base_action(playfield)
    if is_finished || is_passed
      return false
    end

    output_hand
    if has_dia_three
      # ダイヤの3をプレイ
      @cards.each do |card|
        if card.is_dia_three
          play_cards(card, playfield)
        end
      end
    else
      action
    end

    return true if is_finished
    return false
  end

  # 手札を表示
  def output_hand
    puts "Your hand is: " + make_cards_string(@cards)
  end

  # カードを文字列にして返却
  def make_cards_string(cards)
    # 配列ではない場合は配列に
    card_array = cards.is_a?(Array) ? cards : [cards]
    card_descriptions = []
    card_array.each do |card|
      card_descriptions.push(card.description)
    end
    card_descriptions.join(", ")
  end

  # カードをプレイ
  def play_cards(cards, playfield)
    puts "You played: #{make_cards_string(cards)}"
    playfield.update(cards)
    @cards.delete(cards)
  end

  # パス
  def pass
    @is_passed = true
  end

  # パス状態を解除
  def clear_pass
    @is_passed = false
  end

  # 上がっているか否か
  def is_finished
    0 == @cards.count
  end
end
