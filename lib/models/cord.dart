

class Cord {


  int x;
  int y;

  Cord(this.x, this.y);

  Map<String, int> toJson() {
    return {'x': x, 'y': y};
  }

}

extension CordListExtension on List<Cord> {
  List<Map<String, dynamic>> toJsonList() {
    return map((cord) => cord.toJson()).toList();
  }
}