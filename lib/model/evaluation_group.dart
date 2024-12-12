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

  return totalRank;
}
