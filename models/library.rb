class Library
  attr_accessor :cards

  def initialize(joker_count = 0)
    library = []
    total_card_count = 52 + joker_count
    total_card_count.times do |i|
      card = Card.new(i)
      library.push(card)
    end
    # シャッフル
    @cards = library.shuffle
  end

  # 一人あたりに配るカードの２次元配列を返す
  def split_for_players(players_count = 2)
    # 山札の枚数
    all_cards_count = @cards.count
    # プレイヤー数で割って切り捨て
    cards_count_per_player = (all_cards_count.to_f / players_count).floor

    # 一人あたりに配る枚数の配列
    cards_counts = []
    players_count.times do |index|
      cards_counts.push(cards_count_per_player)
    end

    # あまり
    surplus = all_cards_count % players_count
    # もしカードが余るなら
    surplus.times do |index|
      # 配る枚数を1ずつ増やす
      cards_counts[index] += 1
    end

    splited_library = []
    cards_counts.each do |counts|
      range = 0..(counts - 1)
      # 先頭から枚数分の範囲を取り出す
      splited_library.push(@cards[range])
      # 取り出された範囲を削除
      @cards.slice!(range)
    end

    splited_library
  end
end