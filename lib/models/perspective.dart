class Perspective {
  final String perspectiveTitle;

  Perspective(this.perspectiveTitle);

  static List<Perspective> fetchAll() {
    return [
      Perspective('NYC'),
      Perspective('MEDITATION'),
      Perspective('Design'),
      Perspective('Crypto'),
    ];
  }
}
