import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Orders');
  @override
  Widget build(BuildContext context) {
    var dt2 = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch);
    var TAS2 = DateFormat('dd/MM/yyyy').format(dt2);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 119, 194, 255),
                      Color.fromARGB(255, 1, 62, 112),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: SizedBox(
                width: double.infinity,
                height: 222,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Welcome, Admin',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(169, 183, 253, 214)
                          ),
                          child: SizedBox(
                            width: 116,
                            height: 56,
                            child: Column(
                              children: [
                                Icon(Icons.store,color: Colors.white),
                                Text('All Orders', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),),
                                Text('415', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),)
                              ],
                            ),

                          ),
                        ),
                         Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(199, 96, 85, 247)
                          ),
                          child: SizedBox(
                            width: 116,
                            height: 56,
              
                            child: Column(
                              children: [
                                Icon(Icons.motorcycle_outlined,color: Colors.white),
                                Text('Delivered Orders', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),),
                                Text('400', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),)
                              ],
                            ),

                          

                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(169, 250, 231, 57)
                          ),
                          child: SizedBox(
                            width: 116,
                            height: 56,
                            child: Column(
                              children: [
                                Icon(Icons.arrow_back_sharp,color: Colors.white),
                                Text('Returned Orders', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),),
                                Text('8', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),)
                              ],
                            ),

                          ),
                        ),
                         Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(197, 253, 57, 57)
                          ),
                          child: SizedBox(
                            width: 116,
                            height: 56,
              
                            child: Column(
                              children: [
                                Icon(Icons.backspace_sharp,color: Colors.white),
                                Text('Cancelled Orders', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),),
                                Text('7', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),)
                              ],
                            ),

                          ),
                        )
                      ],
                    ),
                    
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Column(
                children: [
                  Text('Orders Summary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                  Container(
                    child: Column(
                      
                      children: [
                        Row(
                          children: [
                            Text('New Orders', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(50, 64, 195, 255),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 140,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Order No.', style: TextStyle(fontWeight: FontWeight.w500),),
                                    Text('Store', style: TextStyle(fontWeight: FontWeight.w500)),
                                    Text('Status',style: TextStyle(fontWeight: FontWeight.w500)),
                                    Text('Date',style: TextStyle(fontWeight: FontWeight.w500))

                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                
                                    Expanded(
                                      
                                      child: FirebaseAnimatedList(
                                         query: dbRef.orderByChild('status').equalTo('Pending'),
                                                        itemBuilder: (BuildContext context, DataSnapshot snapshot,
                                                          Animation<double> animation, int index) {
                                                          Map orders = snapshot.value as Map;
                                                          orders['key'] = snapshot.key;
                                    
                                                          // var dt3 = DateTime.fromMillisecondsSinceEpoch(
                                                          // orders['postTime'].millisecondsSinceEpoch);
                                                          // var TAS3 = DateFormat('dd/MM/yyyy').format(dt3);
                                    
                                                          var dt3 = DateTime.fromMillisecondsSinceEpoch(
                                                              int.parse(orders['postTime']));
                                                          var TAS3 = DateFormat('dd/MM/yyyy').format(dt3);
                                                          if (TAS3.compareTo(TAS2) == 0){
                                                            return GestureDetector(
                                                              onTap: (){},
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Text('${snapshot.key}'),
                                                                      Text('${orders['outlet']}'),
                                                                      Text('${orders['status']}'),
                                                                      Text('$TAS3'),
                                                                      
                                    
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          }
                                                          else{
                                                            return Container();
                                                          }
                                                            }
                                      
                                    
                                      
                                      
                                                                      
                                                                    ),
                                    ),
                                    GestureDetector(
                                      onTap: (){},
                                      child: Row(
                                        children: [
                                          Text('View All', style: TextStyle(color: Colors.red),),
                                          Icon(Icons.arrow_forward_ios, size: 10,color: Colors.red,)

                                        ],
                                      ),
                                    )
                                    
                              ],
                            ),

                          ),
                        )
                      ],
                      
                    ),
                  )
                ],
              ),
            ),
          




          ],
        ),
      ),
    );
  }
}