import 'package:apitesting/question_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration:  BoxDecoration(
            gradient: LinearGradient(colors:[Colors.green,Colors.lightGreen],
                begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white,width: 2),
                    borderRadius: BorderRadius.circular(25)
                  ),
                  child: IconButton(onPressed: () {  },
                      icon: Icon(CupertinoIcons.xmark,color: Colors.white,size: 25,)),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Icon(CupertinoIcons.umbrella_fill,size: 300,color: Colors.yellow,)),
                SizedBox(height: 20,),
                Text('Welcome',
                  style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
                Text('Quiz App',
                  style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold,color: Colors.white),),
                Text('Do what your choice find and sharp mind and enhence your genral konwelde',
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white),),
                SizedBox(height: 30,),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> QuestionScreen()));
                  },
                      child: Text('Continue',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.green),)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
