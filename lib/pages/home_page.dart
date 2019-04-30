import 'package:flutter/material.dart';
import 'package:flutter_login_demo/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_login_demo/models/todo.dart';


import 'dart:async';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab=0;

  PageOne one;
  PageTwo two;
  PageThree three;
  PageFour four;
  List<Widget> pages;
  Widget currentPage;

  
 // List<Todo> _todoList;

  // final FirebaseDatabase _database = FirebaseDatabase.instance;
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /* final _textEditingController = TextEditingController();
  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription; */

  /* Query _todoQuery; */

  bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    one= PageOne();
    two= PageTwo();
    three= PageThree();
    four= PageFour();

    pages = [one, two, three,four];
    super.initState();
    currentPage = one;
    _checkEmailVerification();

    /* _todoList = new List();
    _todoQuery = _database
        .reference()
        .child("todo")
        .orderByChild("userId")
        .equalTo(widget.userId);
    _onTodoAddedSubscription = _todoQuery.onChildAdded.listen(_onEntryAdded);
    _onTodoChangedSubscription = _todoQuery.onChildChanged.listen(_onEntryChanged);*/
  } 

  void _checkEmailVerification() async {
    _isEmailVerified = await widget.auth.isEmailVerified();
    if (!_isEmailVerified) {
      _showVerifyEmailDialog();
    }
  }

  void _resentVerifyEmail(){
    widget.auth.sendEmailVerification();
    _showVerifyEmailSentDialog();
  }

  void _showVerifyEmailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Please verify account in the link sent to email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Resend link"),
              onPressed: () {
                Navigator.of(context).pop();
                _resentVerifyEmail();
              },
            ),
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /*
  void dispose() {
    _onTodoAddedSubscription.cancel();
    _onTodoChangedSubscription.cancel();
    super.dispose();
  }

  _onEntryChanged(Event event) {
    var oldEntry = _todoList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      _todoList[_todoList.indexOf(oldEntry)] = Todo.fromSnapshot(event.snapshot);
    });
  }

  _onEntryAdded(Event event) {
    setState(() {
      _todoList.add(Todo.fromSnapshot(event.snapshot));
    });
  } */

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  /* _addNewTodo(String todoItem) {
    if (todoItem.length > 0) {

      Todo todo = new Todo(todoItem.toString(), widget.userId, false);
      _database.reference().child("todo").push().set(todo.toJson());
    }
  }

  _updateTodo(Todo todo){
    //Toggle completed
    todo.completed = !todo.completed;
    if (todo != null) {
      _database.reference().child("todo").child(todo.key).set(todo.toJson());
    }
  }

  _deleteTodo(String todoId, int index) {
    _database.reference().child("todo").child(todoId).remove().then((_) {
      print("Delete $todoId successful");
      setState(() {
        _todoList.removeAt(index);
      });
    });
  }

  _showDialog(BuildContext context) async {
    _textEditingController.clear();
    await showDialog<String>(
        context: context,
      builder: (BuildContext context) {
          return AlertDialog(
            content: new Row(
              children: <Widget>[
                new Expanded(child: new TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  decoration: new InputDecoration(
                    labelText: 'Add new todo',
                  ),
                ))
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('Save'),
                  onPressed: () {
                    _addNewTodo(_textEditingController.text.toString());
                    Navigator.pop(context);
                  })
            ],
          );
      }
    );
  }*/

  /* Widget _showTodoList() {
   if (_todoList.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _todoList.length,
          itemBuilder: (BuildContext context, int index) {
            String todoId = _todoList[index].key;
            String subject = _todoList[index].subject;
            bool completed = _todoList[index].completed;
            String userId = _todoList[index].userId;
            return Dismissible(
              key: Key(todoId),
              background: Container(color: Colors.red),
              onDismissed: (direction) async {
                _deleteTodo(todoId, index);
              },
              child: ListTile(
                title: Text(
                  subject,
                  style: TextStyle(fontSize: 20.0),
                ),
                trailing: IconButton(
                    icon: (completed)
                        ? Icon(
                      Icons.done_outline,
                      color: Colors.green,
                      size: 20.0,
                    )
                        : Icon(Icons.done, color: Colors.grey, size: 20.0),
                    onPressed: () {
                      _updateTodo(_todoList[index]);
                    }),
              ),
            );
          });
    } else { 
      return Center(child: Text("Welcome. Your list is empty",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30.0),));
    }
  */

  @override
  Widget build(BuildContext context) {

    new ThemeData(
        primarySwatch: Colors.teal,
        canvasColor: Colors.teal,
      );
    return new Scaffold(
     appBar: new AppBar(
        
        

        actions: [
           new IconButton(
            icon: new Image.asset('assets/petlogo2.png'),
            tooltip: 'HomePage',
            onPressed: () => {

            },
          ), 
          new FlatButton(
                child: new Text('Logout',
                    style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: _signOut
                )
        ], 
        title: new Text("Barkery"),
      ),
     
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(  
        currentIndex: currentTab,
        
        onTap: (int index){
          setState(() {
            currentTab=index;
            currentPage=pages[index];
          });

        },
        fixedColor: Colors.white,
                     
        // this will be set when a new tab is tapped
       items: <BottomNavigationBarItem>[
         BottomNavigationBarItem(

           icon: new Icon(Icons.home),
           title: new Text('Home'),
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.pets),
           title: new Text('Pets'),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.person),
           title: Text('Profile')
         ),
          BottomNavigationBarItem(
           icon: new Icon(Icons.contacts),
           title: new Text('Contact us'),
         ),
       ],
     ),

   );

  }
}
class PageOne extends StatelessWidget{
  @override
  Widget build(BuildContext context){
          return Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
             new Image(
            image: new AssetImage("assets/pet2.jpg"),
            fit: BoxFit.cover,
            color: Colors.black87,
            colorBlendMode: BlendMode.darken,
          ),
            Padding(
              padding: EdgeInsets.all(9.0),
              child: TextField(
                cursorColor: Colors.tealAccent,
                style: TextStyle(
                          color: Colors.tealAccent,
                        ),
              
               
                decoration: InputDecoration(
                    
                    labelText: "Search",
                    labelStyle: new TextStyle(
                      color: Colors.tealAccent,fontSize: 20.0),
                    
                    prefixIcon: Icon(Icons.search,color: Colors.tealAccent,),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.tealAccent),
                        borderRadius: BorderRadius.all(Radius.circular(25.0),
                        ),
                        
                        )),
              ),
            ),
            
            
           
          


            new Container(
                  alignment: Alignment.topLeft,
                  margin: new EdgeInsets.only(top: 90, left: 0.0),
              child: Text(
                '     Life is better with a pet.',
                style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 28.0,
                        fontFamily: 'Righteous',
                        fontWeight: FontWeight.normal,)
              ),
            ),

           

      
           new Container(
             
             margin: new EdgeInsets.only(top: 140.0, left: 15.0,right:15.0),
             child: Image(
               
                image: new AssetImage("assets/petlogo.png"),
                color: Colors.black12,
                colorBlendMode: BlendMode.darken,
 
                
              ),
           ),


          ],

        ),
 
      );
  }
}

class PageTwo extends StatelessWidget{
 
  final stories = Expanded(
    child: new Padding(
      padding: const EdgeInsets.only(top: 8.0,bottom: 420.0),
    
      child: 
        new ListView(
        
        scrollDirection: Axis.horizontal,
              children: <Widget>[
                new Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new AssetImage("assets/dog2.jpg"),
                            ),
                  ),
                
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                ),
                new Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new AssetImage("assets/cat.jpg"),
                            ),
                  ),
                
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                ),
                new Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new AssetImage("assets/birds.jpg"),
                            ),
                  ),
                
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                ),
                new Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new AssetImage("assets/fish.jpg"),
                            ),
                  ),
                
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                ),
                new Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new AssetImage("assets/horse.jpg"),
                            ),
                  ),
                
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                ),
                
              ],
        ),
        /* new Image(
            image: new AssetImage("assets/pet2.jpg"),
            fit: BoxFit.cover,
            color: Colors.black87,
            colorBlendMode: BlendMode.darken,
          ),
            Padding(
              padding: EdgeInsets.all(9.0),
              child: TextField(
                cursorColor: Colors.tealAccent,
                style: TextStyle(
                          color: Colors.tealAccent,
                        ),
              
               
                decoration: InputDecoration(
                    
                    labelText: "Search",
                    labelStyle: new TextStyle(
                      color: Colors.tealAccent,fontSize: 20.0),
                    
                    prefixIcon: Icon(Icons.search,color: Colors.tealAccent,),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.tealAccent),
                        borderRadius: BorderRadius.all(Radius.circular(25.0),
                        ),
                        
                        )),
              ),
            ),
            
            
           
          


            new Container(
                  alignment: Alignment.topLeft,
                  margin: new EdgeInsets.only(top: 90, left: 0.0),
              child: Text(
                '     Life is better with a pet.',
                style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 28.0,
                        fontFamily: 'Righteous',
                        fontWeight: FontWeight.normal,)
              ),
            ),

           

      
           new Container(
             
             margin: new EdgeInsets.only(top: 140.0, left: 15.0,right:15.0),
             child: Image(
               
                image: new AssetImage("assets/petlogo.png"),
                color: Colors.black12,
                colorBlendMode: BlendMode.darken,
 
                
              ),
           ),
 */

        
    
  ),);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.all(16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          stories,
        ],),);
  }
}

class PageThree extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
     
      color: Colors.tealAccent,
    );
  }
}

class PageFour extends StatelessWidget{
  @override
  Widget build(BuildContext context){
          return Stack(
            
         
        children: <Widget>[
          Container(
            child:Image.asset(
                'assets/friends.jpg',
              ),
            
            
          ),

        Container(
          color: Colors.black87,

         
         margin: EdgeInsets.only(top:240),
          child: Material(
            
            
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100.0),
            ),

          child: Container(
            
       
            padding: EdgeInsets.only(left: 30.0,top:30.0,right: 10.0,bottom:10.0),
            child: Column(
              children: <Widget>[
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Text("Contributors",style: TextStyle(
                     color:Colors.white,
                     fontSize: 20.0,
                     fontWeight: FontWeight.bold,
                  
                   ),),
                   Icon(Icons.group_work,color: Colors.white,)
                 ],
                ),
                SizedBox(height: 30,),
               
                Row(
                  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
                 children: <Widget>[
                   Text(" Baddam Kalyan ",style: TextStyle(
                     color:Colors.white,
                     fontSize: 14.0,
                     fontWeight: FontWeight.bold,
                     
                  
                   ),),
                  Text(" Sai Rajeswar ",style: TextStyle(
                     color:Colors.white,
                     fontSize: 14.0,
                     fontWeight: FontWeight.bold,
                     
                  
                   ),),
                 ],
                ),
                 Padding(
                  padding: EdgeInsets.only(top:10.0),
                ),

                 Row(
                  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
                 children: <Widget>[
                   Text("Aniket Raj ",style: TextStyle(
                     color:Colors.white,
                     fontSize: 14.0,
                     fontWeight: FontWeight.bold,
                  
                   ),),
                  Text(" Shashwat Gupta ",style: TextStyle(
                     color:Colors.white,
                     fontSize: 14.0,
                     fontWeight: FontWeight.bold,
                     
                  
                   ),),
                   
                 ],
                ), 
                 Padding(
                  padding: EdgeInsets.only(top:10.0),
                ),
                Row(
                  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
                 children: <Widget>[
                   Text("Suvarat Trivedi ",style: TextStyle(
                     color:Colors.white,
                     fontSize: 14.0,
                     fontWeight: FontWeight.bold,
                     
                  
                   ),),
                  Text(" Dhruv Nair ",style: TextStyle(
                     color:Colors.white,
                     fontSize: 14.0,
                     fontWeight: FontWeight.bold,
                     
                  
                   ),),
                   
                 ],
                ), 
                
                  Padding(
                    padding: EdgeInsets.only(top: 25),
                  ),
                   
                  
                              
              ],
            ),
          ),
          ),
        ),

        ],
      );
  }
}