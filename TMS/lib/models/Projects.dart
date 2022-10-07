// ignore_for_file: file_names, non_constant_identifier_names

class Projects {
  String id;
  String description;
  bool isDone;

  Projects({required this.id, required this.description, this.isDone = false});

  static List<Projects> Pro_list() {
    return [
      Projects(id: '01',description: 'School managment system',isDone:true),
      Projects(id: '02',description: 'Ecommerce',isDone:true),
      Projects(id: '03',description: 'CPMS'),
      Projects(id: '04',description: 'ATS',),
      Projects(id: '05',description: 'Calander'),
      Projects(id: '06',description: 'TMS'),
    ];
  }
}
