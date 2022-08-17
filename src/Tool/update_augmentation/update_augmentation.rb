require "CSV"

group_20 = [
    "カムラノ装","レザーＸ","チェーンＸ",
    "ハンターＸ","アロイＸ","アケノＸ",
    "ボロスＸ","ラングロＸ"
]
group_18 = [
    "インゴットＸ","メルホアＸ","混沌",
    "エーデルＸ","スカルダＸ","スパイオＸ",
    "アルブーロＸ","テンゴＸ","イソネＸ",
    "ズワロＸ","フルフルＸ","レイアＸ",
    "バサルＸ","プケプケＸ","ジュラＸ",
    "カガチＸ","ジャナフＸ","テンゴＺ",
    "ゴギョウ","ユクモノ"
]
group_16 = [
    "ドーベルＸ","マカルパＸ","デスギアＸ",
    "マギュルＸ","ロワーガＸ","ファルメルＸ",
    "ヴァイクＸ","ヤツカダＸ","ゴシャＸ",
    "オロミドＸ","ナルガＸ","ベリオＸ",
    "スカルＸ","禍鎧","ブリゲイドＸ",
    "ギザミ","イソネＺ","ゴルム",
    "ギルドバード","スカラー","ガーディアン",
    "軽装騎士","砲術隊"
]
group_14 = [
    "ウツシ表","神凪・洸","ウツシ裏",
    "依巫・燿","ガブラスＸ","コトルＸ",
    "レウスＸ","レックスＸ","ディアブロＸ",
    "ジンオウＸ","クロムメタルＸ","ミツネＸ",
    "ゴア","レギオス","ゼクス",
    "ヤツカダＺ","オロミドＺ","ルナガロ",
    "エスピナ","ホーク","エコール",
    "バルバニア","グローシア","重装騎士",
    "ディグニ",
]
group_12 = [
    "ダマスクＸ","メデュレトＸ","クシャナＸ",
    "ミヅハ真","カイザーＸ","斉天",
    "バゼルＸ","アーク","フィリア",
    "メルゼ","プロフ","シャリテ",
    "セイラー","サージュ","シーカー",
]
group_10 = [
    "赫耀","怒天","禍鎧・怨",
    "プライド","冥淵纏鎧","拠点司令",
    "ギルドパレス","ゴールドルナ","シルバーソル",
    "月光","翔駆の羽根飾り","祝福の羽根飾り",
    "しまき","なるかみ",
]

group = {
    20 => [40, 12, group_20],
    18 => [32, 8, group_18],
    16 => [26, 2, group_16],
    14 => [20, 1, group_14],
    12 => [16, 0, group_12],
    10 => [12, -6, group_10],
}

Dir.glob("*.csv") do |csv|
    puts csv
    read_data = CSV.read(csv, encoding: "UTF-8")
    write_data = []
    is_csv_header = true
    for line in read_data
        remake_val = 0
        remake_max_def = 0
        remake_max_def2 = 0
        original_name = line[0]
        rank = line[2].to_i
        name = original_name.gsub("ヘルム","").gsub("ヘッド","").gsub("フード","")
        name = name.gsub("アーム","").gsub("篭手","").gsub("グローブ","")
        name = name.gsub("メイル","").gsub("スーツ","").gsub("ベスト","")
        name = name.gsub("コイル","").gsub("ベルト","").gsub("アンカ","").gsub("フォールド","")
        name = name.gsub("グリーヴ","").gsub("フット","")
        is_end = false
        for key, val in group
            max_def = val[0]
            max_def2 = val[1]
            group_sub = val[2]
            for group_name in group_sub
                if name.include?(group_name) && rank >= 8
                    remake_val = key
                    remake_max_def = max_def
                    remake_max_def2 = max_def2
                    is_end = true
                    break if is_end
                end
            end
            break if is_end
        end
        puts "#{original_name} : #{remake_val}, #{remake_max_def}"
        if is_csv_header
            line.push("傀異錬成初期コスト")
            line.push("傀異錬成最大防御＋")
            line.push("傀異錬成2スロ追加時最大防御＋")
            is_csv_header = false
        else
            line.push(remake_val)
            line.push(remake_max_def)
            line.push(remake_max_def2)
        end
        write_data.push(line)
    end
    CSV.open("output/" + csv,'w') do |file|
        for line in write_data
            file << line
        end
    end
    #break
end 