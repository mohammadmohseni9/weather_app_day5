String getDayTimeBasedOnTimeRanges(String date) {
  // استخراج ساعت و دقیقه از رشته تاریخ و زمان
  final time = date.split(' ')[1];
  final hour = int.parse(time.split(':')[0]);
  final minute = int.parse(time.split(':')[1]);
  if (hour >= 6 && hour <= 12) {
    return 'Morning';
  } else if (hour >= 12 && hour <= 16) {
    return 'noonday';
  } else if (hour > 16 && hour <= 23) {
    return 'AfterNoon';
  } else {
    return 'Night';
  }
}
