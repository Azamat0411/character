
class Character{
  String image;
  String name;
  String status;
  String species;

  Character(this.image, this.name, this.status, this.species);

  factory Character.fromJson(dynamic json){
    return Character(json['image'], json['name'], json['status'], json['species']);
  }
}
