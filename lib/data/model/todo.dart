class Todo
{
  late int? id;
  late String title;
  late String detail;

  Todo({this.id, required this.title, required this.detail});
  Map<String,dynamic> toMap() {
    return{
      "id":id,
      "title":title,
      "detail":detail
    };
  }
  Todo.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"];
    detail = map["detail"];
  }
}