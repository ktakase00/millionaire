class Card
  attr_accessor :mark, :number, :power

  def initialize(id)
    @mark = get_mark(id)
    @number = get_number(id)
    @power = get_power
  end

  def get_mark(id)
    if (0..12).include?(id)
      "dia"
    elsif (13..25).include?(id)
      "heart"
    elsif (26..38).include?(id)
      "clover"
    elsif (39..51).include?(id)
      "spade"
    else
      "joker"
    end
  end

  def get_number(id)
    if (0..12).include?(id)
      # ダイヤ
      num = id
    elsif (13..25).include?(id)
      # ハート
      num = id - 13
    elsif (26..38).include?(id)
      # クローバー
      num = id - 26
    elsif (39..51).include?(id)
      # スペード
      num = id - 39
    else
      # ジョーカー
      num = 13
    end

    num += 1

    if 1 == num
      return "A"
    elsif (2..10).include?(num)
      return num.to_s
    elsif 11 == num
      return "J"
    elsif 12 == num
      return "Q"
    elsif 13 == num
      return "K"
    else
      return "JOKER"
    end
  end

  # 大富豪におけるカードの強さ
  def get_power
    case @number
    when "3" then 0
    when "4" then 1
    when "5" then 2
    when "6" then 3
    when "7" then 4
    when "8" then 5
    when "9" then 6
    when "10" then 7
    when "J" then 8
    when "Q" then 9
    when "K" then 10
    when "A" then 11
    when "2" then 12
    else 13
    end
  end

  # ダイヤの3か否か
  def is_dia_three
    "3" == @number && "dia" == @mark
  end

  # 文字列にする
  def description
    @mark + " " + @number
  end
end

