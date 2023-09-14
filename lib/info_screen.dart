import 'package:flutter/material.dart';
import 'package:calc_application/utils/calculate.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          body: SizedBox(
            width: double.infinity,
          
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              
              children: [
                
                  Padding(padding: const EdgeInsets.only(right: 25,left: 25 , top: 5, bottom: 5),
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 81, 255, 87),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                      
                    ) ,
                    
                    child: const Text('مدیریت تراکنش ها به تومان', 
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                    
                    
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 2, bottom: 240, right: 2),
                    alignment: Alignment.center,
                    width:450,
                    height : 200,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 127, 118),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                
                    ),
                    child: Column(
                      children: [
                  MoneyInfoWidget(firsttext: ':دریافتی امروز' , firstprice: Calculate.dtoday().toString(), secondtext: ':پرداختی امروز', secondprice: Calculate.pToday().toString(), ),
                  MoneyInfoWidget(firsttext: ':دریافتی این ماه' , firstprice: Calculate.dmonth().toString(), secondtext: ':پرداختی این ماه', secondprice: Calculate.pmonth().toString(), ),
                  MoneyInfoWidget(firsttext: ':دریافتی امسال' , firstprice: Calculate.dyear().toString(), secondtext: ':پرداختی امسال', secondprice: Calculate.pyear().toString(), ),
                
                      ],
                    ),
                
                  ),
                )

              ],
            ),
          )
        
        ),
    );
    
  }
}

class MoneyInfoWidget extends StatelessWidget {
   
final String firsttext;
final String secondtext;
final String firstprice;
final String secondprice;

const MoneyInfoWidget({super.key, 
  required this.firsttext,
  required this.secondtext,
  required this.firstprice,
  required this.secondprice
  });
  @override
  Widget build(BuildContext context) {
    return  Padding(padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children:  [
           Expanded(child:
           Text(firstprice)
          ),
          Text(secondtext  , 
          textAlign: TextAlign.right
          ),
           Expanded(
            child: 
            Text(secondprice, 
            textAlign: TextAlign.right
             )
            ),
           Text(firsttext),
         
          
        ],
      ),
    );
  }
}