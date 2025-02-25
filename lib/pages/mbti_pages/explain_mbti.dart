String explainMbti(String type) {
  switch (type) {
    case "INTJ":
      return "INTJ（建築家）は、戦略的な思考と計画性に優れたタイプで、独立心が強く、他人に頼らず問題解決に取り組む姿勢が特徴です。また、論理的で革新的な解決策を見つける能力が高く、抽象的な概念や理論を扱うことに喜びを感じます。";
    case "INTP":
      return "INTP（論理学者）は、独創的な思考と理論的な探求心に優れたタイプで、知識を追求し、複雑な問題に挑むことに喜びを感じます。独自の視点で新しい可能性を模索し続けます。";
    case "ENTJ":
      return "ENTJ（指揮官）は、カリスマ性とリーダーシップを備え、効率的な計画で目標達成を導くことに優れる実践的な戦略家です。強い決断力で周囲を鼓舞し、困難な状況を乗り越えます。";
    case "ENTP":
      return "ENTP（討論者）は、柔軟な発想と冒険的な精神で、新しいアイデアを創造し、議論を通じて革新を促すことを得意とするタイプです。自由な発想をもとに次々と挑戦を続けます。";
    case "INFJ":
      return "INFJ（提唱者）は、深い洞察力と強い信念を持ち、人々の成長を支援しながら未来への理想を追求する共感力のあるタイプです。困難な状況でも心の絆を重視し、導く力があります。";
    case "INFP":
      return "INFP（仲介者）は、感受性豊かで深い共感を持ち、個人的な価値観を大切にしながら、理想的な世界を求めて努力するタイプです。他者への思いやりを行動で示すことを信条としています。";
    case "ENFJ":
      return "ENFJ（主人公）は、他者を導くカリスマ性と人々を鼓舞する能力を備え、コミュニティを強化しながら調和を重視するリーダーです。人々の潜在能力を引き出す力にも長けています。";
    case "ENFP":
      return "ENFP（広報運動家）は、熱意と創造性に溢れた自由な精神の持ち主で、好奇心旺盛にアイデアを追求し、人々に影響を与えるタイプです。新しい挑戦を楽しみながら周囲を元気づけます。";
    case "ISTJ":
      return "ISTJ（管理者）は、強い責任感と実践的な能力を持ち、伝統やルールを重視しながら効率的に物事を進める実務的なタイプです。計画通りに物事を進める信頼感のある存在です。";
    case "ISFJ":
      return "ISFJ（擁護者）は、献身的で親切な性格を持ち、周囲の人々を支えながら、他者の幸福に尽力する温かい心の持ち主です。穏やかな態度で周囲の環境を和らげます。";
    case "ESTJ":
      return "ESTJ（幹部）は、秩序と伝統を尊重し、効率的な方法で目標を達成するために、チームを統率するリーダータイプです。結果を重視しながら現実的な判断を下します。";
    case "ESFJ":
      return "ESFJ（領事官）は、他者への気配りと社交的な性格を兼ね備え、周囲の人々の幸福と調和を重視して行動するタイプです。共感力を活かして円滑な人間関係を築きます。";
    case "ISTP":
      return "ISTP（巨匠）は、現実的で柔軟な問題解決能力を持ち、実践的なスキルを活用しながら、独自の方法で課題を克服するタイプです。新たな発見や工夫に喜びを見いだします。";
    case "ISFP":
      return "ISFP（冒険者）は、感受性豊かで自由を尊重するタイプで、美的な感覚を活かして、柔軟で創造的なアプローチを取ります。自然体でのびのびと生きる姿勢が魅力です。";
    case "ESTP":
      return "ESTP（起業家）は、行動力と冒険心を備えた活発なタイプで、目の前の機会を最大限に活用しながら成果を追求する実践派です。周囲を巻き込みつつ新しい挑戦を続けます。";
    case "ESFP":
      return "ESFP（エンターテイナー）は、魅力的で社交的な性格を持ち、楽しい雰囲気を作りながら、人々を惹きつけて場を盛り上げるタイプです。自分自身もその場を楽しむのが得意です。";
    default:
      return "このタイプの説明はまだ用意されていません。";
  }
}

String famousMBTI(String type) {
  switch (type) {
    case "INTJ":
      return "イーロン・マスク、レオナルド・ダ・ヴィンチ\n夏目漱石、ベートーヴェン";
    case "INTP":
      return "アインシュタイン、ビル・ゲイツ\n野口英世、本居宣長";
    case "ENTJ":
      return "スティーブ・ジョブズ、ジェフ・ベゾス\n織田信長、豊臣秀吉";
    case "ENTP":
      return "トーマス・エジソン、マーク・トウェイン\n坂本龍馬、森鷗外";
    case "INFJ":
      return "マザー・テレサ、ガンディー\n宮沢賢治、聖徳太子";
    case "INFP":
      return "ジョン・レノン、J.K.ローリング\n西郷隆盛、石川啄木";
    case "ENFJ":
      return "バラク・オバマ、オプラ・ウィンフリー\n明治天皇、吉田松陰";
    case "ENFP":
      return "ウォルト・ディズニー、ロビン・ウィリアムズ\n渋沢栄一、美空ひばり";
    case "ISTJ":
      return "徳川家康、乃木希典\nアンゲラ・メルケル、ジョージ・ワシントン";
    case "ISFJ":
      return "ビヨンセ、フローレンス・ナイチンゲール\n板垣退助、北里柴三郎";
    case "ESTJ":
      return "ヘンリー・フォード、ジョージ・パットン\n松下幸之助、原敬";
    case "ESFJ":
      return "テイラー・スウィフト、ジェニファー・ロペス\n上杉鷹山、美智子皇后";
    case "ISTP":
      return "ブルース・リー、アーノルド・シュワルツェネッガー\n葛飾北斎、東郷平八郎";
    case "ISFP":
      return "マイケル・ジャクソン、オードリー・ヘプバーン\n黒澤明、小林一茶";
    case "ESTP":
      return "ドウェイン・ジョンソン、ウィル・スミス\n豊川悦司、市川團十郎";
    case "ESFP":
      return "エルヴィス・プレスリー、マイリー・サイラス\n美空ひばり、北島三郎";
    default:
      return "このタイプの有名人は分かりません。";
  }
}

String goodMbti(String type) {
  switch (type) {
    case "INTJ":
      return "長期的な目標を設定し、それに向かって効率的に行動すること";
    case "INTP":
      return "新しい理論を考案し、論理的に分析すること";
    case "ENTJ":
      return "戦略的に計画を立て、リーダーシップを発揮すること";
    case "ENTP":
      return "柔軟な発想で新しいアイデアを生み出すこと";
    case "INFJ":
      return "深い洞察力で未来のビジョンを描くこと";
    case "INFP":
      return "理想を追求し、他者に深く共感すること";
    case "ENFJ":
      return "他者を励まし、協力を引き出すリーダーシップ";
    case "ENFP":
      return "独創的なアイデアを生み出し、情熱を注ぐこと";
    case "ISTJ":
      return "計画的に物事を進め、責任を全うすること";
    case "ISFJ":
      return "他者を思いやり、細やかにサポートすること";
    case "ESTJ":
      return "効率よく組織を管理し、目標を達成すること";
    case "ESFJ":
      return "周囲を気遣い、親身に支援すること";
    case "ISTP":
      return "分析力を活かし、実践的に問題を解決すること";
    case "ISFP":
      return "感性を活かして、創造的に自己表現すること";
    case "ESTP":
      return "行動力を発揮し、状況に即した決断を下すこと";
    case "ESFP":
      return "社交的で場を明るくし、人々を楽しませること";
    default:
      return "このタイプの説明はまだ用意されていません。";
  }
}

String badMbti(String type) {
  switch (type) {
    case "INTJ":
      return "感情に寄り添った対応や即興的な柔軟性を求められること";
    case "INTP":
      return "感情を共有することや日常的な事務作業";
    case "ENTJ":
      return "感情的な要素に寄り添うことや即興的な対応";
    case "ENTP":
      return "細かい部分を気にし、感情に配慮すること";
    case "INFJ":
      return "現実的な問題に素早く対応すること";
    case "INFP":
      return "現実的な課題を迅速に解決すること";
    case "ENFJ":
      return "細部を注意深く管理すること";
    case "ENFP":
      return "一貫性を持って計画を遂行すること";
    case "ISTJ":
      return "予想外の変化に柔軟に対応すること";
    case "ISFJ":
      return "自分の意見を主張し、リスクを取ること";
    case "ESTJ":
      return "感情的な要素に配慮した柔軟な対応";
    case "ESFJ":
      return "独立して動いたり論理的な議論をすること";
    case "ISTP":
      return "感情的な交流や長期的な計画を立てること";
    case "ISFP":
      return "対立に直面したり厳格なルールに従うこと";
    case "ESTP":
      return "長期的な計画を立てたり慎重に進めること";
    case "ESFP":
      return "細かい計画を守ったり規律に従うこと";
    default:
      return "このタイプの説明はまだ用意されていません。";
  }
}
