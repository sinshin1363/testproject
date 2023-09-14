import 'package:calc_application/models/money.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

 Box<Money> hivebox = Hive.box<Money>('moneybox');
String year = Jalali.now().year.toString();
String month = Jalali.now().month.toString().length == 1 ? '0${ Jalali.now().month.toString()}' : Jalali.now().month.toString();
String day = Jalali.now().day.toString().length == 1 ? '0${Jalali.now().day.toString()}' : Jalali.now().day.toString();

String today = ('$year/$month/$day'); 
class Calculate {

  static double pToday() {
    
    double resualt = 0;
    for (var value in hivebox.values) {
      if(value.date == today && value.isReceived == false) {
         resualt += double.parse(value.price!);
      }

    }
        return resualt;
  }


  static double dtoday() {
    double resualt = 0;
    for(var value in hivebox.values) {
      if(value.date == today && value.isReceived == true ) {
          resualt += double.parse(value.price!);
      }
    }
  return resualt;
}

static double pmonth(){
  double resualt = 0 ;
  for(var value in hivebox.values) {
    if(value.date?.substring(5,7) == month && value.isReceived == false) {
      resualt += double.parse(value.price!);
    }

  }
  return resualt;
}
static double dmonth() {
  double resualt = 0;
for(var value in hivebox.values) {
  if(value.date?.substring(5,7) == month && value.isReceived == true) {
    resualt += double.parse(value.price!);
  }

}
return resualt;
}

static double pyear() {
  double resualt = 0;
  for(var value in hivebox.values) {
    if(value.date?.substring(0,4) == year && value.isReceived == false) {
      resualt += double.parse(value.price!);
    }
  }

  return resualt;
}

static double dyear() {
  double resualt = 0;
  for(var value in hivebox.values) {
    if(value.date?.substring(0,4) == year && value.isReceived == true) {
      resualt += double.parse(value.price!);
    }
  }
  return resualt;
}
}