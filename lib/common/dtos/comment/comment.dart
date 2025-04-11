
class CommentDto {
  final String content;

  final int postActualityId;
  final List<int> mentions;

  CommentDto({
    required this.content,
    required this.postActualityId,
    required this.mentions,
  });

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'post_actuality_id': postActualityId,
      'mentions': mentions,
    };
  }
}

