class ListFiles {
  final String title;
  final int id, quantity;
  final double perQuantityPrice;
  ListFiles({this.id, this.title, this.perQuantityPrice, this.quantity});
}

final listfiles = List<ListFiles>.generate(
  100,
  (index) => ListFiles(
    id: index,
    title: "Product Name" + (index + 1).toString(),
    quantity: (index + 1) * 300,
    perQuantityPrice: 40 * (index + 1).toDouble(),
  ),
);
