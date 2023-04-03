enum IconEnum {
  lArrow('left_arrow'),
  add('add_outline'),
  home('home'),
  person('person'),
  like('heart'),
  onboard('onboard'),
  comment('comment');

  final String value;
  const IconEnum(this.value);
  String get toSvg => 'assets/icons/$value.svg';
}
