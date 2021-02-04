class ListFiles {
  final String title, time, notes;
  final int id;
  final double money;
  final bool posMin;
  ListFiles({
    this.id,
    this.title,
    this.time,
    this.money,
    this.posMin,
    this.notes,
  });
}

List<ListFiles> listfiles = [
  ListFiles(
    id: 1,
    title: "Salary",
    time: "31-12-2020",
    money: 4343,
    posMin: true,
    notes:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
  ),
  ListFiles(
    id: 1,
    title: "Salary",
    time: "31-12-2020",
    money: 4343,
    posMin: true,
    notes: null,
  ),
  ListFiles(
    id: 1,
    title: "Salary",
    time: "31-12-2020",
    money: 4343,
    posMin: true,
    notes:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
  ),
  ListFiles(
    id: 1,
    title: "Movie",
    time: "31-12-2020",
    money: 4343,
    posMin: false,
    notes:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
  ),
  ListFiles(
    id: 1,
    title: "Movie",
    time: "31-12-2020",
    money: 4343,
    posMin: false,
    notes:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
  ),
  ListFiles(
    id: 1,
    title: "Movie",
    time: "31-12-2020",
    money: 4343,
    posMin: false,
    notes:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
  ),
  ListFiles(
      id: 1, title: "Movie", time: "31-12-2020", money: 4343, posMin: false),
  ListFiles(
      id: 2, title: "Movie", time: "31-12-2020", money: 4343, posMin: false),
  ListFiles(
      id: 3, title: "Movie", time: "31-12-2020", money: 4343, posMin: false),
];
