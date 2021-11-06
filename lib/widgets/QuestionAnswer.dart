import 'package:animate_icons/animate_icons.dart';
import 'package:chat_app_with_firebase/pages/JoinAsSellerV2.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'DecorationWidgets.dart';

class QuestionAnswer extends StatefulWidget {
  final String question;
  final String answer;
  final bool answerIsRichText;
  final Widget richText;
  QuestionAnswer({@required this.question, this.answer,@required this.answerIsRichText, this.richText});

  @override
  _QuestionAnswerState createState() => _QuestionAnswerState();
}

class _QuestionAnswerState extends State<QuestionAnswer> {
  AnimateIconController arrowController;
  bool isAnswerOpen = false;

  @override
  void initState() {
    arrowController = AnimateIconController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Visibility(
        visible: true,
        child: Column(
          children: [
            SizedBox(height: 5,),
            GestureDetector(
              onTap: () {
                if (arrowController.isStart()) {
                  arrowController.animateToEnd();
                  setState(() {
                    isAnswerOpen = true;
                  });
                } else if (arrowController.isEnd()) {
                  arrowController.animateToStart();
                  setState(() {
                    isAnswerOpen = false;
                  });
                }
                print("Clicked!");
/*                            Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                  Text("Animate using controller, onPress not called"),
                                  duration: Duration(seconds: 1),
                                ),
                              );*/


              },
              child: Container(
                color: Colors.white.withOpacity(0.00), //יש צורך כדי שGestureDetector יעבוד
                child:
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.85,
                          // height: 45,
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child:  Text(widget.question, //"מה עלי לעשות?",
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              overflow: TextOverflow.clip,
                              softWrap: true,
                              style: simpleTextBold(fontSize: 18, color: Colors.grey[dark].withOpacity(0.85) ),
                            ),
                          ),
                        ),
                        AnimateIcons(
                          controller: arrowController,
                          startIcon: Icons.keyboard_arrow_down,
                          endIcon: Icons.keyboard_arrow_up,
                          size: 30.0,
                          onStartIconPress: () {
                            print("Clicked on Add Icon");
                            setState(() {
                              isAnswerOpen = true;
                            });
                            return true;
                          },
                          onEndIconPress: () {
                            print("Clicked on Close Icon");
                            setState(() {
                              isAnswerOpen = false;
                            });
                            return true;
                          },
                          duration: Duration(milliseconds: 150),
                          // color: Colors.black.withOpacity(0.20),
                          clockwise: false,
                        ),
                      ],
                    ),
                    Transform.translate(
                      offset: Offset(0, -10),
                      child:
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 350),
                        crossFadeState: isAnswerOpen ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                        firstChild:
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 48.5),
                          child: widget.answerIsRichText ?
                          widget.richText
                          : Text( widget.answer, //"עליך לפרסם את קופון ההנחה שתקבל מאיתנו, להדפיס את ההזמנות של לקוחותיך ולשלוח אותם אליהם",
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: simpleText(fontSize: 18, color: Colors.grey[dark].withOpacity(0.65) ),
                          ),
                        ),
                        secondChild: Container(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        )
    );
  }
}
