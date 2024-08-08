class GetRoomId {
  String? getRoomId(String url) {
    if (url.isEmpty) {
      return '';
    }

    Uri? uri;
    try {
      uri = Uri.parse(url);
    } catch (e) {
      return '';
    }

    if (uri.hasQuery) {
      final roomId = uri.queryParameters['roomId'];
      if (roomId != null && roomId.isNotEmpty) {
        return roomId;
      } else {
        return '';
      }
    } else {
      return '';
    }
  }
}
