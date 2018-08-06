class CategoryModel {
  String categoryName;
  bool selected;

  CategoryModel(this.categoryName, this.selected);

  CategoryModel.fromJson(Map<dynamic, dynamic> json)
      : categoryName = json['category_name'],
        selected = json['selected'];

  Map<String, dynamic> toJson() => {
        'category_name': categoryName,
        'selected': selected,        
      };

  // String get getCategoryName => categoryName;
  // bool get getSelected => selected;  
}
