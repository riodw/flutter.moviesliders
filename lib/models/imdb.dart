class ImdbModel {
  final String title;
  final String id;
  final String staring;
  final int year;
  final String type;
  final media;

  ImdbModel(
      {this.title, this.id, this.staring, this.year, this.type, this.media});

  factory ImdbModel.fromJson(Map<String, dynamic> json) {
    return ImdbModel(
      title: json['l'],
      id: json['id'],
      staring: json['s'],
      year: json['y'],
      type: json['q'],
      media: json['i'],
    );
  }
}
