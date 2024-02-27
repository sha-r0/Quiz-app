import 'dart:async';

import 'package:apitesting/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late Future quiz;
  var isloaded = false;
  var optionlist = [];
  var optioncolor = List<Color>.filled(5, Colors.white);
  int currentquestionindex = 0;
  int second = 60;
  Timer? timer;
  int points = 0;

  @override
  void initState() {
    super.initState();
    quiz = getquiz();
    starttimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  starttimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (second > 0) {
          second--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  resetColor() {
    setState(() {
      optioncolor = List<Color>.filled(5, Colors.white);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: quiz,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data["results"];
              var questionData = data[currentquestionindex];
              var incorrectAnswer = questionData["incorrect_answers"] ?? [];
              var correctAnswer = questionData["correct_answer"];

              if (!isloaded) {
                optionlist = List.from(incorrectAnswer);
                optionlist.add(correctAnswer);
                optionlist.shuffle();
                isloaded = true;
              }

              return  Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green, Colors.lightGreen],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  CupertinoIcons.back,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  '$second',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: CircularProgressIndicator(
                                    value: second / 60,
                                    valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                                  ),
                                )
                              ],
                            ),
                            TextButton(
                              onPressed: null,
                              child: Icon(
                                Icons.favorite,
                                size: 38,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20,),
                        Icon(
                          CupertinoIcons.building_2_fill,
                          size: 200,
                          color: Colors.yellow,
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Question ${currentquestionindex + 1} of ${data.length}",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          questionData["question"],
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: optionlist.length,
                          itemBuilder: (BuildContext context, int index) {
                            var answer = questionData["correct_answer"];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (answer == optionlist[index]) {
                                      optioncolor[index] = Colors.green;
                                      points += 10;
                                    } else {
                                      optioncolor[index] = Colors.red;
                                    }

                                    if (currentquestionindex <
                                        data.length - 1) {
                                      Future.delayed(Duration(seconds: 1), () {
                                        isloaded = false;
                                        currentquestionindex++;
                                        resetColor();
                                        timer?.cancel();
                                        second = 60;
                                        starttimer();
                                      });
                                    } else {
                                      timer?.cancel();
                                    }
                                  });
                                },
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: optioncolor[index],
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      optionlist[index],
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                        ,
                      ],
                    ),
                  ),
                );

            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
