enum SchoolLevel {
  elementary('Elementary'),
  juniorHigh('Junior High School'),
  seniorHigh('Senior High School');

  const SchoolLevel(this.label);
  final String label;
}

enum GradeLevel {
  kinder('Kinder', SchoolLevel.elementary),
  grade1('Grade 1', SchoolLevel.elementary),
  grade2('Grade 2', SchoolLevel.elementary),
  grade3('Grade 3', SchoolLevel.elementary),
  grade4('Grade 4', SchoolLevel.elementary),
  grade5('Grade 5', SchoolLevel.elementary),
  grade6('Grade 6', SchoolLevel.elementary),
  grade7('Grade 7', SchoolLevel.juniorHigh),
  grade8('Grade 8', SchoolLevel.juniorHigh),
  grade9('Grade 9', SchoolLevel.juniorHigh),
  grade10('Grade 10', SchoolLevel.juniorHigh),
  grade11('Grade 11', SchoolLevel.seniorHigh),
  grade12('Grade 12', SchoolLevel.seniorHigh);

  const GradeLevel(this.label, this.schoolLevel);
  final String label;
  final SchoolLevel schoolLevel;
}
