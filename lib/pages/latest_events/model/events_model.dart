class Events {
  final int id;
  final String eventName;
  final String eventContent;
  final String location;
  final String eventImage;
  final String eventDate;
  final String eventDuration;
  bool isLiked;
  bool isBookmarked;
  final String createdAt;
  final String updatedAt;

  Events({
    required this.id,
    required this.eventName,
    required this.eventContent,
    required this.location,
    required this.eventImage,
    required this.eventDate,
    required this.eventDuration,
    required this.isLiked,
    required this.isBookmarked,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Events.fromJson(Map<String, dynamic> json) {
    return Events(
      id: json['id'] ?? 0,
      eventName: json['event_name'] ?? "",
      eventContent: json['event_content'] ?? "",
      location: json['location'] ?? "",
      eventImage: json['event_image'] ?? "",
      eventDate: json['event_date'] ?? "",
      eventDuration: json['event_duration'] ?? "",
      isLiked: json['is_liked'] ?? false,
      isBookmarked: json['is_bookmarked'] ?? false,
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
    );
  }
}
