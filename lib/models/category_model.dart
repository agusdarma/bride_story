class CategoryModel {
  String categoryName;
  int categoryId;
  bool selected;

  CategoryModel(this.categoryName,this.categoryId, this.selected);

  CategoryModel.fromJson(Map<dynamic, dynamic> json)
      : categoryName = json['category_name'],
        selected = json['selected'],
        categoryId = json['categoryId'];

  Map<String, dynamic> toJson() => {
        'category_name': categoryName,
        'selected': selected,        
        'categoryId': categoryId,        
      };

  // String get getCategoryName => categoryName;
  // bool get getSelected => selected;  
}
