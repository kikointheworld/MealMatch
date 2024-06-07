class Info {
  final String? containsBeef;
  final String? containsDairy;
  final String? containsEggs;
  final String? containsFish;
  final String? containsHalal;
  final String? containsPork;
  final String? containsSeafood;
  final String? referencedRecipe;

  Info({
    this.containsBeef,
    this.containsDairy,
    this.containsEggs,
    this.containsFish,
    this.containsHalal,
    this.containsPork,
    this.containsSeafood,
    this.referencedRecipe,
  });

  factory Info.fromJson(Map<dynamic, dynamic> json) {
    return Info(
        containsBeef: json.containsKey("contains_beef") ? json["contains_beef"] : null,
        containsDairy: json.containsKey("contains_dairy") ? json["contains_dairy"] : null,
        containsEggs: json.containsKey("contains_eggs") ? json["contains_eggs"] : null,
        containsFish: json.containsKey("contains_fish") ? json["contains_fish"] : null,
        containsHalal: json.containsKey("contains_halal") ? json["contains_halal"] : null,
        containsPork: json.containsKey("contains_pork") ? json["contains_pork"] : null,
        containsSeafood: json.containsKey("contains_seafood") ? json["contains_seafood"] : null,
        referencedRecipe: json.containsKey("referenced_recipe") ? json["referenced_recipe"] : null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "contains_beef": containsBeef,
      "contains_dairy": containsDairy,
      "contains_eggs": containsEggs,
      "contains_fish": containsFish,
      "contains_halal": containsHalal,
      "contains_pork": containsPork,
      "contains_seafood": containsSeafood,
      "referenced_recipe": referencedRecipe,
    };
  }
}
