import 'package:app_base/model/evaluation_group.dart';
import 'package:app_base/pages/result.dart';
import 'package:flutter/material.dart';

Future<void> navigateResult(BuildContext context, MBTI, member) async {
  Map<String, Map<String, int>> checkList = {
    "INTJ": {
      "INTJ": 3,
      "INTP": 3,
      "INFJ": 2,
      "INFP": 3,
      "ENTP": 2,
      "ENFP": 4,
      "ENTJ": 4,
      "ENFJ": 2,
      "ISTJ": 4,
      "ISFJ": 4,
      "ISTP": 3,
      "ISFP": 2,
      "ESTJ": 2,
      "ESFJ": 1,
      "ESTP": 4,
      "ESFP": 5
    },
    "INTP": {
      "ESFP": 1,
      "ENTJ": 2,
      "ENFP": 2,
      "ISFJ": 2,
      "ISTP": 2,
      "ESTP": 2,
      "INTJ": 3,
      "INTP": 3,
      "INFJ": 3,
      "ISTJ": 3,
      "ENTP": 4,
      "INFP": 4,
      "ENFJ": 4,
      "ESTJ": 4,
      "ISFP": 4,
      "ESFJ": 5
    },
    "INFJ": {
      "ISFJ": 3,
      "INTP": 4,
      "INFJ": 3,
      "ENFJ": 4,
      "ISTJ": 3,
      "ESFP": 4,
      "ENTJ": 5,
      "ENTP": 1,
      "ENFP": 2,
      "ESTP": 2,
      "INTJ": 2,
      "INFP": 2,
      "ESTJ": 4,
      "ESFJ": 2,
      "ISTP": 4,
      "ISFP": 3
    },
    "INFP": {
      "ESTP": 1,
      "ENTP": 2,
      "ENFJ": 2,
      "ISTJ": 2,
      "ISFP": 2,
      "ESFP": 2,
      "INTJ": 3,
      "INFJ": 3,
      "INFP": 3,
      "ISFJ": 3,
      "INTP": 4,
      "ENTJ": 4,
      "ENFP": 4,
      "ESFJ": 4,
      "ISTP": 4,
      "ESTJ": 5
    },
    "ENTJ": {
      "ISFJ": 1,
      "INTP": 2,
      "INFJ": 2,
      "ENFJ": 2,
      "ISTJ": 2,
      "ESFP": 2,
      "ENTJ": 3,
      "ENTP": 3,
      "ENFP": 3,
      "ESTP": 3,
      "INTJ": 4,
      "INFP": 4,
      "ESTJ": 4,
      "ESFJ": 4,
      "ISTP": 4,
      "ISFP": 5
    },
    "ENTP": {
      "ISFP": 1,
      "INTJ": 2,
      "INFP": 2,
      "ESFJ": 2,
      "ISTP": 2,
      "ESTP": 2,
      "ENTJ": 3,
      "ENTP": 3,
      "ENFJ": 3,
      "ESTJ": 3,
      "INTP": 4,
      "INFJ": 4,
      "ENFP": 4,
      "ISTJ": 4,
      "ESFP": 4,
      "ISFJ": 5
    },
    "ENFP": {
      "ISTP": 1,
      "INTP": 2,
      "INFJ": 2,
      "ESTJ": 2,
      "ISFP": 2,
      "ESFP": 2,
      "ENTJ": 3,
      "ENFJ": 3,
      "ENFP": 3,
      "ESFJ": 3,
      "INTJ": 4,
      "ENTP": 4,
      "INFP": 4,
      "ISFJ": 4,
      "ESTP": 4,
      "ISTJ": 5
    },
    "ENFJ": {
      "ISTJ": 1,
      "INTJ": 2,
      "ENTJ": 2,
      "INFP": 2,
      "ISFJ": 2,
      "ESTP": 2,
      "ENTP": 3,
      "ENFJ": 3,
      "ENFP": 3,
      "ESFP": 3,
      "INTP": 4,
      "INFJ": 4,
      "ESTJ": 4,
      "ESFJ": 4,
      "ISFP": 4,
      "ISTP": 5
    },
    "ISTJ": {
      "ENFJ": 1,
      "ENTJ": 2,
      "INFP": 2,
      "ISFJ": 2,
      "ESFJ": 2,
      "ESTP": 2,
      "INTP": 3,
      "ISTJ": 3,
      "ISTP": 3,
      "ISFP": 3,
      "INTJ": 4,
      "ENTP": 4,
      "INFJ": 4,
      "ESTJ": 4,
      "ESFP": 4,
      "ENFP": 5
    },
    "ISTP": {
      "ENFP": 1,
      "INTP": 2,
      "ENTP": 2,
      "INFJ": 2,
      "ESTJ": 2,
      "ESFP": 2,
      "INTJ": 3,
      "ISTJ": 3,
      "ISFJ": 3,
      "ISTP": 3,
      "ENTJ": 4,
      "INFP": 4,
      "ESFJ": 4,
      "ISFP": 4,
      "ESTP": 4,
      "ENFJ": 5
    },
    "ISFJ": {
      "ENTJ": 1,
      "INTP": 2,
      "ENFJ": 2,
      "ISTJ": 2,
      "ESTJ": 2,
      "ESFP": 2,
      "INFP": 3,
      "ISFJ": 3,
      "ISTP": 3,
      "ISFP": 3,
      "INTJ": 4,
      "INFJ": 4,
      "ENFP": 4,
      "ESFJ": 4,
      "ESTP": 4,
      "ENTP": 5
    },
    "ISFP": {
      "ENTP": 1,
      "INTJ": 2,
      "INFP": 2,
      "ENFP": 2,
      "ESFJ": 2,
      "ESTP": 2,
      "INFJ": 3,
      "ISTJ": 3,
      "ISFJ": 3,
      "ISFP": 3,
      "INTP": 4,
      "ENFJ": 4,
      "ESTJ": 4,
      "ISTP": 4,
      "ESFP": 4,
      "ENTJ": 5
    },
    "ESTJ": {
      "INFJ": 1,
      "INTJ": 2,
      "ENFP": 2,
      "ISFJ": 2,
      "ESFJ": 2,
      "ISTP": 2,
      "ENTP": 3,
      "ESTJ": 3,
      "ESTP": 3,
      "ESFP": 3,
      "INTP": 4,
      "ENTJ": 4,
      "ENFJ": 4,
      "ISTJ": 4,
      "ISFP": 4,
      "INFP": 5
    },
    "ESTP": {
      "INFP": 1,
      "INTP": 2,
      "ENTP": 2,
      "ENFJ": 2,
      "ISTJ": 2,
      "ISFP": 2,
      "ENTJ": 3,
      "ESTJ": 3,
      "ESFJ": 3,
      "ESTP": 3,
      "INTJ": 4,
      "ENFP": 4,
      "ISFJ": 4,
      "ISTP": 4,
      "ESFP": 4,
      "INFJ": 5
    },
    "ESFJ": {
      "INTJ": 1,
      "ENTP": 2,
      "INFJ": 2,
      "ISTJ": 2,
      "ESTJ": 2,
      "ISFP": 2,
      "ENFP": 3,
      "ESFJ": 3,
      "ESTP": 3,
      "ESFP": 3,
      "ENTJ": 4,
      "INFP": 4,
      "ENFJ": 4,
      "ISFJ": 4,
      "ISTP": 4,
      "INTP": 5
    },
    "ESFP": {
      "INTP": 1,
      "ENTJ": 2,
      "INFP": 2,
      "ENFP": 2,
      "ISFJ": 2,
      "ISTP": 2,
      "ENFJ": 3,
      "ESFJ": 3,
      "ESTJ": 3,
      "ESFP": 3,
      "ENTP": 4,
      "INFJ": 4,
      "ISFP": 4,
      "ISTJ": 4,
      "ESTP": 4,
      "INTJ": 5
    },
  };

  int totalrank = mbtiCheck(MBTI, checkList);
  int index = 1;
  List<int> chartValue = [1, 5, 3, 4, 5, 4]; // サンプルデータ
  chartValue[0] = calculateValue(MBTI, "E");
  chartValue[1] = calculateValue(MBTI, "T") + 1;
  chartValue[2] = calculateValue(MBTI, "S") + 1;
  chartValue[3] = calculateValue(MBTI, "SF") + 1;
  chartValue[4] = calculateValue(MBTI, "J");
  chartValue[5] = calculateValue(MBTI, "EF") + 1;

  Map<String, String> nameAndMBTIDict = {};

  for (int i = 0; i < member.length; i++) {
    // 名前を取得
    String name = member[i];

    // MBTIを取得
    String mbti = MBTI[i];

    // 辞書に追加（名前をキー、MBTIを値とする）
    if (name.isNotEmpty && mbti.isNotEmpty) {
      nameAndMBTIDict[name] = mbti;
    }
  }

  List<int> compatibilityScores = mbtiValue(nameAndMBTIDict, checkList);

  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => ResultScreen(
              totalrank: totalrank,
              chartValue: chartValue,
              index: index,
              NameAndMbti: nameAndMBTIDict,
              compatibilityScores: compatibilityScores,
            )),
  );
  print(nameAndMBTIDict);
}
