import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/colors.dart';

const unFoucusedBorder =
    UnderlineInputBorder(borderSide: BorderSide(color: tabColor));
const foucusedBorder =
    UnderlineInputBorder(borderSide: BorderSide(color: tabColor, width: 2));

final darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: backgroundColor,
  appBarTheme: const AppBarTheme().copyWith(
    foregroundColor: tabColor,
  ),
  inputDecorationTheme: const InputDecorationTheme().copyWith(
    border: unFoucusedBorder,
    focusedBorder: foucusedBorder,
    enabledBorder: unFoucusedBorder,
  ),
  textButtonTheme: TextButtonThemeData(
    style: const ButtonStyle().copyWith(
      foregroundColor: const MaterialStatePropertyAll(tabColor),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: const ButtonStyle().copyWith(
      foregroundColor: const MaterialStatePropertyAll(blackColor),
      backgroundColor: const MaterialStatePropertyAll(tabColor),
    ),
  ),
  
);

final lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: whiteColor,
  appBarTheme: const AppBarTheme().copyWith(
    foregroundColor: lightTabColor,
  ),
  inputDecorationTheme: const InputDecorationTheme().copyWith(
    border: unFoucusedBorder,
    focusedBorder: foucusedBorder,
    enabledBorder: unFoucusedBorder,
  ),
  textButtonTheme: TextButtonThemeData(
    style: const ButtonStyle().copyWith(
      foregroundColor: const MaterialStatePropertyAll(tabColor),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: const ButtonStyle().copyWith(
      foregroundColor: const MaterialStatePropertyAll(whiteColor),
      backgroundColor: const MaterialStatePropertyAll(lightTabColor),
    ),
  ),
);
