import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_project/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todo_project/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo_project/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo_project/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates>
{
 AppCubit() : super(AppInitialState());
 static AppCubit get(context) =>  BlocProvider.of(context);

 late Database database;
 List<Map> tasks = [];
 
  int currentIndex = 0;
 List<Widget> screens = [
  NewTasksScreen(),
  DoneTasksScreen(),
  ArchivedTasksScreen(),
 ];
 List<String> titles = [
  'New Tasks',
  'Done Tasks',
  'Archived Tasks',
 ];

 void changeIndex(int index)
 {
  currentIndex = index;
  emit(AppChangeBottomNavBarState());
 }

 void createDatabase()  
 {
  openDatabase(
   'todo.db',
   version: 1,
   onCreate: (database, version) {
    print('Database Created');
    database
        .execute(
        'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
        .then((value) {
     print('table created');
    }).catchError((error) {
     print('Error When Creating Table ${error.toString()}');
    });
   },
   onOpen: (database) {

    getDataFromDatabase(database).then((value)
    {
     tasks = value;
     print(tasks);
     emit(AppGetDatabaseState());
    });


    print('Database opened');
   },
  ).then((value) 
  {
    database = value;
    emit(AppCreateDatabaseState());
  },
  );
 }

 insertToDatabase({
  required String title,
  required String time,
  required String date,
 }) async {
  await database.transaction((txn) async {
   txn
       .rawInsert(
    'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$time", "$date", "new")',
   )
       .then((value) {
    print('$value inserted successfully');
    emit(AppInsertDatabaseState());

    getDataFromDatabase(database).then((value)
    {
     tasks = value;
     print(tasks);
     emit(AppGetDatabaseState());
    });
   }).catchError((error) {
    print('Error When Inserting New Record ${error.toString()}');
   });
   return null;
  });
 }

 Future<List<Map>> getDataFromDatabase(database) async
 {
  return await database.rawQuery('SELECT * FROM tasks');

 }

 bool isBottomSheetShown = false;
 IconData fabIcon = Icons.edit;

 void changeBottomSheetsState({
  required bool isShow,
  required IconData icon,
 })
 {
  isBottomSheetShown = isShow;
  fabIcon = icon;


  emit(AppChangeBottomSheetState());
 }
}