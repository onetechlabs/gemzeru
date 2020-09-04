import 'dart:math';

Random random = Random();
List names = [
  "Ling Waldner",
  "Gricelda Barrera",
  "Lenard Milton",
  "Bryant Marley",
  "Rosalva Sadberry",
  "Guadalupe Ratledge",
  "Brandy Gazda",
  "Kurt Toms",
  "Rosario Gathright",
  "Kim Delph",
  "Stacy Christensen",
];

List job_position = [
  "Member",
];

List gameName = [
  "Game 1",
  "Game 2",
  "Game 3",
  "Game 4",
];

/*List posts = List.generate(
    13,
    (index) => {
          "version": "1.0",
          "gameCover": "assets/${random.nextInt(10)}.jpeg",
          "category": "Undefined Kategori",
          "gameName": "${gameName[random.nextInt(3)]}",
          "desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sed nibh at turpis tincidunt sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Curabitur a dignissim lectus. Duis tempor velit ut feugiat sollicitudin."
        });*/


class ProfileData {
  static String idGoogle;
  static String photourlGoogle;
  static String emailGoogle;
  static String displaynameGoogle;
  static String id;
  static String gameCode;
  static String fullName;
  static String address;
  static String phone;
  static String token;
  static String status_active;
}
