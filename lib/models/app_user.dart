class AppUser {
  const AppUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.avatarUrl,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? avatarUrl;
}
