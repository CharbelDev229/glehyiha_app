class ProfileViewSelectItem {
  final int index;
  final String name;
  final void Function()? onPressed;

  ProfileViewSelectItem({required this.index, required this.name, this.onPressed});
}