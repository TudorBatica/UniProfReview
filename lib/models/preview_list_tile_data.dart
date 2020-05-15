import 'package:professor_review/models/information_list_tile_data.dart';

class PreviewListTileData {
  final List<InformationListTileData> data;
  final Function onTap;
  final double rating;

  PreviewListTileData({this.onTap, this.data, this.rating});
}
