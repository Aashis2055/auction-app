/// function format iso date into year, month and day
String formatDate(date){
 var dateObj = DateTime(date);
 int year = dateObj.year;
  int month = dateObj.month;
  int day = dateObj.day;

  return "$year/$month/$day";
}