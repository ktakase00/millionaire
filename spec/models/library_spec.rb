require './spec/spec_helper'

RSpec.describe "Library" do
  context "ジョーカー0枚の場合" do
    
    before(:all) do
      @total_card_count = 52
    end
    
    # 各プレイヤーに配布されるカードの数を表す配列を生成
    def make_splited_count_ary(player_count)
      ary = []
      split_size = (@total_card_count / player_count).floor
      surplus = @total_card_count % player_count
      
      (1..player_count).each do |index|
        ary.push(split_size + (index <= surplus ? 1 : 0))
      end
#      p ary
      ary
    end
    
    describe "カードを均等に" do
      
      (2..10).each do |player_count|
        it "#{player_count}人に配布できること" do
          # 各プレイヤーに配布されるカードの数を表す配列
          splited_count_ary = make_splited_count_ary(player_count)
          
          # 山札を作成
          library = Library.new(0)
          
          # 山札を人数分に分ける
          splited_library = library.split_for_players(player_count)
          
          # 山札の分割数がプレイヤーの数と一致すること
          expect(splited_library.length).to eq(player_count)
          
          # 各プレイヤーに配布されたカードの枚数が正しいこと
          splited_library.each_with_index do |player_library, index|
            card_count = splited_count_ary[index]
            expect(player_library.length).to eq(card_count)
          end
        end
      end
      
    end
  end
end
