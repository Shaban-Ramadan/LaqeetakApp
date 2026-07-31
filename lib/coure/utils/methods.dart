String generateChatId(String user1Id, String user2Id) {
  // نرتب الـ IDs عشان يكون الـ chatId نفسه للطرفين
  final ids = [user1Id, user2Id]..sort();
  return ids.join('_'); // مثال: "uid1_uid2"
}