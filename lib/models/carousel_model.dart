class CarouselModel {
  String imageName;
  int status;
  int id;

  CarouselModel(this.imageName,this.status, this.id);

  CarouselModel.fromJson(Map<dynamic, dynamic> json)
      : imageName = json['imageName'],
        status = json['status'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'imageName': imageName,
        'status': status,        
        'id': id,        
      };

  // String get getCategoryName => categoryName;
  // bool get getSelected => selected;  
}