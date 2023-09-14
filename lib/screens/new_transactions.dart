import 'dart:math';

import 'package:calc_application/models/money.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class NewTransactionsScreen extends StatefulWidget {
  const NewTransactionsScreen({super.key});
  static int groupId = 0;
   static TextEditingController descriptionController = TextEditingController();
   static TextEditingController priceController = TextEditingController();
   static bool isEditing = false;
   static int index = 0;
    static String date = 'تاریخ';


  @override
  State<NewTransactionsScreen> createState() => _NewTransactionsScreenState();
}

class _NewTransactionsScreenState extends State<NewTransactionsScreen> {


  Box<Money> hiveBox = Hive.box<Money>('moneyBox');



  @override
  
  Widget build(BuildContext context) {
    
    return   SafeArea(
      child:  Scaffold(
        backgroundColor: Colors.white,
        body: Padding(padding: const EdgeInsets.all(25),
          child: SizedBox(width: double.infinity,
            child:  
              Column(crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                 Text(NewTransactionsScreen.isEditing ? 'ویرایش تراکنش' : 'تراکنش جدید',
                 style: const TextStyle(fontSize: 18)
                  ,),
                   MyTextfield(hinttext: 'توضیحات', controller: NewTransactionsScreen.descriptionController , 
                   ),
                    MyTextfield(hinttext: 'مبلغ',type: TextInputType.number, controller: NewTransactionsScreen.priceController,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                       Expanded(
                         child: MyRadioWidget(
                          groupValue: NewTransactionsScreen.groupId,
                           value:1,
                            onChanged: (value){
                              setState(() {
                                NewTransactionsScreen.groupId = value!;
                                
                              });
                            },
                          
                            ),
                       ),
                          const Text('دریافتی'),
                       Expanded(
                         child: MyRadioWidget(
                          groupValue: NewTransactionsScreen.groupId,
                           value:2,
                          onChanged: (value){
                          setState(() {
                            NewTransactionsScreen.groupId = value!;
                            
                          });
                         }),
                       ),
                          const Text('پرداختی'),



                        Padding(padding: const EdgeInsets.all(15),
                         child: OutlinedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.grey) ,
                            ),
                         
                           onPressed: () async {
                          var pickedDate = await showPersianDatePicker(
                             context: context,
                           initialDate: Jalali.now(), 
                           firstDate: Jalali(1400),
                            lastDate: Jalali(1499)
                          );
                          setState(() {
                            
                            String year = pickedDate!.year.toString();
                            String month = pickedDate.month.toString().length ==1 ? '0${pickedDate.month.toString()}' : pickedDate.month.toString();
                            String day = pickedDate.day.toString().length ==1 ? '0${pickedDate.day.toString()}' : pickedDate.day.toString();
                            NewTransactionsScreen.date = '$year/$month/$day';


                          });
                         
                         
                           }, 
                             child: Text(NewTransactionsScreen.date , style: const TextStyle(fontSize: 11, color: Colors.black), 
                             )
                          ),
                          ),

                           ],

                       ),

                         SizedBox(
                        
                          width: double.infinity, 
                          height: 40,
                            child: ElevatedButton( 

                              child:  Text(NewTransactionsScreen.isEditing 
                              ? 'ویرایش تراکنش'
                              : 'اضافه کردن تراکنش', 
                              style:const TextStyle(fontSize: 15),), 

                            onPressed: (){
                              Money item   =  Money(
                                   id: Random().nextInt(9999),
                                    tittle: NewTransactionsScreen.descriptionController.text,
                                     price: NewTransactionsScreen.priceController.text,
                                      date: NewTransactionsScreen.date, 
                                       isReceived: NewTransactionsScreen.groupId == 1  ? true : false,
                                       );
                              if (NewTransactionsScreen.isEditing) {
                                //HomeScreen.moneis[NewTransactionsScreen.index] = item;
                                hiveBox.putAt(NewTransactionsScreen.index, item);
                              }
                              else {
                                 //HomeScreen.moneis.add(item);
                                 
                                  hiveBox.add(item);
                                  }

                               

                            },
                             ), 
                        ),

                   ],

                   
                   
                ),
             ),
        )
      ),
    );
  }
}

class MyRadioWidget extends StatelessWidget {
 final int? value;
 final int? groupValue;
 final Function(int?) onChanged;


  const MyRadioWidget({super.key,
   required this.value, 
    required this.groupValue,
     required this.onChanged,
       
  });

  @override
  Widget build(BuildContext context) {
     return Radio( 
      value: value!,
       groupValue: groupValue!,
        onChanged: onChanged , 
 
   );
   
  }
}

class MyTextfield extends StatefulWidget {
    final String hinttext;
    final TextInputType type;
    final TextEditingController controller;

    const MyTextfield({super.key,  required this.hinttext, this.type = TextInputType.text, required this.controller
    
  });

  @override
  State<MyTextfield> createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.type,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: widget.hinttext,
      
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey
          )
        ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)
          )
      ),
    );
  }
}