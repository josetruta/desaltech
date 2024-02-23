enum Model {
  padrao,
  edu
}

class DesalTech {
  const DesalTech({
    required this.uid,
    required this.createdAt,
    required this.location,
    required this.model
  });
  
  final String uid;
  final DateTime createdAt;
  final String location;
  final Model model;
}