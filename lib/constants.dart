import 'package:flutter/material.dart';

//העמוד בו האפליקציה נמצאת (ברירת מחדל = 0)
int myPageIndex = 0;

int dark = 900;
Color spiderRed = Colors.red[dark];

//רקע לדיאלוג, גלובלי כדי שFeedWidget יוכל לשנות את הצבע לAppBarWidget
Color backgroundColor = Colors.black26;

//מאפשר לחזור לעמוד הנוכחי של "מודלים" גם ע"י לחיצה על הCustomNavigator
bool onThingWebViewPage = true;