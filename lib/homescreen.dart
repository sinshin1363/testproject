import 'package:calc_application/constant.dart';
import 'package:calc_application/main.dart';
import 'package:calc_application/models/money.dart';
import 'package:calc_application/screens/new_transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';

// ignore: camel_case_types
class HomeScreen extends StatefulWidget {
   
   static List<Money> moneis = [];
    final TextEditingController searchController = TextEditingController();
     final BorderRadius borderRadius = BorderRadius.circular(20);
       static Box<Money> hiveBox = Hive.box<Money>('moneyBox');

  HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _homescreenState();
}

// ignore: camel_case_types
class _homescreenState extends State<HomeScreen> {

  final BorderRadius borderRadius = BorderRadius.circular(20);
    Box<Money> hiveBox = Hive.box<Money>('moneyBox');

  @override
  void initState() {
    MyApp.getdata();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
   
    return SafeArea(
      child: Scaffold(
         backgroundColor: Colors.white,
           floatingActionButton: Container(alignment: Alignment.bottomCenter,
             child: FloatingActionButton(
           
             backgroundColor: Colors.white,
                   
              elevation: 0, 
              onPressed: () {
                NewTransactionsScreen.date = 'تاریخ';
                NewTransactionsScreen.descriptionController.text = '' ;
                NewTransactionsScreen.priceController.text = '' ;
                NewTransactionsScreen.isEditing = false;
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const NewTransactionsScreen(),
           
                  ),
                     
                  ).then((value) {
           
                  MyApp.getdata();
                    setState(() {
                    
                  });
                  });
                  
              },
             child: const Icon(Icons.add, color: Colors.black, size: 38,), 
             
                     ),
           ),
          body:   Column(
           children: [
            const HeaderWidget(), 
            //Expanded (child: EmptyWidget())

             //MyListTileWidget(),
             Expanded(
             child: HomeScreen.moneis.isEmpty ? const EmptyWidget() :
                 ListView.builder(
           
                 itemCount: HomeScreen.moneis.length ,
                 itemBuilder: (context, index) {
                   return GestureDetector(child: MyListTileWidget(index: index),
                   onTap: () {
                     NewTransactionsScreen.date = HomeScreen.moneis[index].date!;
                     NewTransactionsScreen.descriptionController.text
                     = HomeScreen.moneis[index].tittle!;
                     NewTransactionsScreen.priceController.text 
                     =HomeScreen.moneis[index].price!;
                     NewTransactionsScreen.index = index;
                     if (HomeScreen.moneis[index].isReceived!) {
                       NewTransactionsScreen.groupId = 1;
                     } else {
                       NewTransactionsScreen.groupId = 2;
                     }
                     NewTransactionsScreen.isEditing = true;
                     Navigator.push(context, MaterialPageRoute(
                       builder: (context) => const NewTransactionsScreen()
                       )
                       ).then((value) {
                         MyApp.getdata();
                        setState(() {
                         
                          
                        });
                       })
                       ;
                      },
                  onLongPress: () {
                   showDialog(context: context, builder: (context) => AlertDialog(
                     title:  const Text('از حذف مطمئن هستید؟',
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                       textAlign: TextAlign.center, ),
                     actionsAlignment: MainAxisAlignment.spaceBetween,
                     actions: [

                     TextButton(onPressed: (){
                       Navigator.pop(context);
                     },
                      child: const Text('لغو', style: TextStyle(color: Colors.black87),)),
                     TextButton(onPressed: (){
                       hiveBox.deleteAt(index);
                       MyApp.getdata();
                       setState(()
                        {
                      // HomeScreen.moneis.removeAt(index);
                       
                       });
                       Navigator.pop(context);
                     }, child: const Text('تایید',style: TextStyle(color: Colors.black87),)),
                   ],
                   ),
                    );
                    
                 setState(() {
                    
                   
                 });
                  },
                   );


               }
               
               
               ),
                        
                           
             ),
             ],
           
          ),
      ),
    );
  }
  
}

class MyListTileWidget extends StatefulWidget {
  final int? index;
  const MyListTileWidget({required this.index, 
    super.key,
  });

  @override
  State<MyListTileWidget> createState() => _MyListTileWidgetState();
}

class _MyListTileWidgetState extends State<MyListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
        
      children: [
      
        Padding(padding: const EdgeInsets.all(20),
          child: Container(
            
            width: 60,
            height: 60, 
            
            decoration: BoxDecoration(
              color: HomeScreen.moneis[widget.index!].isReceived! ? kGreenColor : kRedColor,
              borderRadius: BorderRadius.circular(15),
              
            ),
            child: Icon(HomeScreen.moneis[widget.index!].isReceived! ? Icons.add : Icons.remove,
            color: Colors.white, size: 30,),
            
        
            
          ),

          ),

               Text(HomeScreen.moneis[widget.index!].tittle!),
              const Spacer(),
                Padding(padding: const EdgeInsets.only(right: 20),
                child: Column(
                  
                  children: [
                    Row(
                       children: [
                      Text('تومان',style: TextStyle(fontSize: 14, color: HomeScreen.moneis[widget.index!].isReceived! ? Colors.green : Colors.red), 
                     
                     ),
                    Text(HomeScreen.moneis[widget.index!].price!,style: const TextStyle(fontSize: 15) ,
                       
                    )

                       ]
                    ),
                       Text(HomeScreen.moneis[widget.index!].date!,style: const TextStyle(fontSize: 15),),
                  
                
                  ],
              
                ),
             
              ), 
    
      ]
      
    );
  }
}

//HeaderWidget
class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(20),
      child: Row(
        children: [
           
          Expanded(
            child: SizedBox(
              width: 100,
              child: TextField(

              decoration: InputDecoration(
                hintText: '...جستجو',
                border: OutlineInputBorder(
                  borderRadius:
                   BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                  
                
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              style: const TextStyle(fontSize: 18),
            ),
            ),
          ),
          const SizedBox(width: 25),
             const Text('تراکنش ها', style: TextStyle(fontSize: 18))   
            
        ],
          
      ),
    );
  }
}

//EmptyWidget
class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column( 
      children: [
                        const Spacer(),
                SvgPicture.asset(
                  'assets/images/calc.svg' ,
                  height: 200,
                  width: 200,
                  ),
                  const SizedBox(height: 20),
                 const Text('!تراکنشی موجود نیست',style: TextStyle(fontSize: 17),),
                  
                const Spacer(),
      ],
      
    ); 
  }
}

  