int mbtiCheck(
    List<String> peopleMbti, Map<String, Map<String, int>> checkList) {
  /*
    peopleMbti : List of MBTI types in the group as strings
    checkList  : Map containing MBTI compatibility scores as nested maps

    --> Returns the sum of compatibility scores (total rank)
  */

  // Initialize total rank
  int totalRank = 0;
  // Generate all pairs of MBTI combinations
  for (int i = 0; i < peopleMbti.length; i++) {
    for (int j = i + 1; j < peopleMbti.length; j++) {
      String mbti1 = peopleMbti[i];
      String mbti2 = peopleMbti[j];

      // Retrieve rank from checkList and add to total
      totalRank += checkList[mbti1]?[mbti2] ?? 0;
    }
  }

  double denominator = (peopleMbti.length * (peopleMbti.length - 1)) * 5 / 2;
  if (120 - (totalRank * 100 / denominator).round() < 100) {
    return 120 - (totalRank * 100 / denominator).round();
  } else {
    return 100;
  }
}

List<int> mbtiValue(
    Map<String, String> peopleMbti, Map<String, Map<String, int>> checkList) {
  /*
    peopleMbti : List of MBTI types in the group as strings
    checkList  : Map containing MBTI compatibility scores as nested maps

    --> Returns the sum of compatibility scores (total rank)
  */

  // 結果を格納するリスト
  List<int> compatibilityScores = [];

  // peopleMbtiのキー（名前）をリストに変換
  List<String> people = peopleMbti.keys.toList();
  int count = 0;

  // 全てのペアを生成して、対応するスコアをチェックリストから取得
  for (int i = 0; i < people.length; i++) {
    for (int j = i + 1; j < people.length; j++) {
      count = count + 1;
      String mbti1 = peopleMbti[people[i]]!;
      String mbti2 = peopleMbti[people[j]]!;

      // checkList からスコアを取得
      int score = checkList[mbti1]?[mbti2] ?? 0; // デフォルト値として0を設定

      // スコアをリストに追加
      compatibilityScores.add(score);
    }
  }
  print(count);
  print('by function1');
  print(compatibilityScores);

  return compatibilityScores;
}

int calculateValue(List<String> targetList, String targetChar) {
  /// 指定された文字がリストの要素に含まれる割合を計算する関数。

  // ターゲット文字を含む要素をカウント
  int count = targetList.where((item) => item.contains(targetChar)).length;

  // リストが空でない場合、割合を計算
  double percentage =
      targetList.isNotEmpty ? (count / targetList.length) * 100 : 0;

  // 割合に応じた数値を返す
  if (percentage <= 20) {
    return 1;
  } else if (percentage <= 40) {
    return 2;
  } else if (percentage <= 60) {
    return 3;
  } else if (percentage <= 80) {
    return 4;
  } else {
    return 5;
  }
}

String calculateMBTI(Map<int, String> answers) {
  if (answers.length != 4) {
    return "わからない";
  }

  // 簡単なロジック: 質問ごとにMBTIの要素を決定
  String eOrI = answers[0] == "はい" ? "E" : "I";
  String jOrP = answers[1] == "はい" ? "J" : "P";
  String tOrF = answers[2] == "はい" ? "F" : "T";
  String nOrS = answers[3] == "はい" ? "N" : "S";

  return "$eOrI$nOrS$tOrF$jOrP";
}

List<String> countAndSortMBTILetters(Map<String, String> mbtiDict) {
  // 初期値として、各MBTI文字のカウントを 0 に設定したマップを作成
  Map<String, int> letterCount = {
    'I': 0,
    'E': 0,
    'N': 0,
    'S': 0,
    'T': 0,
    'F': 0,
    'J': 0,
    'P': 0
  };

  // MBTIタイプを抽出してアルファベットをカウント
  mbtiDict.values.forEach((mbti) {
    for (var letter in mbti.split('')) {
      // 文字が 'I', 'E', 'N', 'S', 'T', 'F', 'J', 'P' に含まれていればカウント
      if (letterCount.containsKey(letter)) {
        letterCount[letter] = (letterCount[letter] ?? 0) + 1;
      }
    }
  });

  // カウントされた結果を降順でソート
  var sortedLetters = letterCount.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  // ソートされたアルファベットだけのリストを作成して返す
  var finalSortedLetters = sortedLetters.map((entry) => entry.key).toList();

  print(finalSortedLetters);
  return finalSortedLetters;
}
