enum TypeInd {
  empty(1),
  mother(2),
  father(3),
  brother(4);

  const TypeInd(this.value);
  final num value;
  String get description => name.toUpperCase();
}
