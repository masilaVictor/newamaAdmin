import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            decoration: BoxDecoration(
              color: Colors.blue
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    transform: Matrix4.translationValues(0, -60.0, 0),
                    child: Image.asset('assets/images/newama2.png',color: Colors.red,),
                  )

                ),
                
                Container(
                    transform: Matrix4.translationValues(0, -150, 0.0),
                    margin: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40))
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 600,
                      child: Column(
                        children: [
                          Image.asset('assets/images/rider.png'),
                          Container(
                            margin: EdgeInsets.fromLTRB(70, 0, 70, 0),
                            transform: Matrix4.translationValues(0, -60, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(onPressed: (){}, 
                                child: Text('Store Panel', style: TextStyle(fontSize: 17),),
                                ),
                                ElevatedButton(onPressed: (){}, 
                                child: Text('Admin',style: TextStyle(fontSize: 17)))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  
                )
              ],
              
            ),

          
        ),
        
      ),
    );
  }
}
