class Game
  attr_accessor :players, :playfield

  def initialize(players_count, jokers_count = 0)
    # 山札を作成
    library = Library.new(jokers_count)
    players = []
    man_flag = true
    players_count.times do
      # player = Player.new()
      if man_flag
        player = ManPlayer.new()
        man_flag = false
      else
        player = ComPlayer.new()
      end
      players.push(player)
    end

    # 山札を人数分に分ける
    splited_library = library.split_for_players(PLAYERS_COUNT)

    # カードを配る
    players.each_with_index do |player, index|
      player.cards = splited_library[index]
    end

    # プレイの順番の番号の配列を作成
    play_orders = []
    players_count.times do |i|
      play_orders.push(i + 1)
    end
    play_orders.delete(1)
    play_orders.shuffle
    # プレイの順番決定
    soated_players = []
    players.each do |player|
      if player.has_dia_three
        player.play_order = 1
      else
        order = play_orders.first
        player.play_order = order
        play_orders.shift
      end
      # プレイ順番でソートされた配列を作成
      soated_players[player.play_order - 1] = player
    end
    @players = soated_players
    @playfield = Playfield.new()
  end

  # ゲームスタート
  def start
    puts "Game start."
    finished_players = []

    # 終わるまで続ける
    while !is_finished do
      @players.each do |player|
        # 場を流すかチェック
        clear_playfield_if_needed if !player.is_passed
        # 上がったらそのプレイヤー名を配列に追加
        finished_players.push(player.name) if player.base_action(@playfield)
      end
    end
    puts "results: #{finished_players.to_s}"
  end

  # 必要なら場を流す
  def clear_playfield_if_needed
    passed_count = 0
    @players.each do |player|
      passed_count += 1 if player.is_passed
    end
    playing_count = @players.count - passed_count
    # 一人を除いてパスしている場合
    if 2 > playing_count
      @playfield.clear
      @players.each do |player|
        player.clear_passed
      end
    end
  end

  # ゲームが続いているか否か
  def is_finished
    finished_count = 0
    @players.each do |player|
      finished_count += 1 if player.is_finished
    end
    playing_count = @players.count - finished_count
    2 > playing_count
  end
end