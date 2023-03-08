import 'package:flutter/material.dart';
import 'package:flutter_todo_test/getList.dart';
import 'Dialog.dart';

List<Map<String, dynamic>> todoList = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  var getList = GetList();

  @override
  void initState() {
    super.initState();
    print("initState start");
    getList.getList();
  }

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;
    final inputText = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('ToDo TEST')),
      body: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 8,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 16),
                itemBuilder: (context, index) {
                  final todo = todoList[index];
                  return Container(
                    height: 60,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenSize.width * 0.75,
                          child: Row(
                            children: [
                              Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                  value: todo['isFinish'] == "false" ? false : true,
                                  onChanged: (v) {
                                    getList.changeCheckBox(index,isFalse(v.toString()));
                                    setState(() {
                                      todo['isFinish'] = v.toString();
                                      print(todo['isFinish']);
                                    });
                                  },
                                  side: const BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  todo['content'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(onPressed: (){
                          showDialog<String>(
                              context: context,
                              builder: (_) {
                                return SimpleDialogSample(index:index);
                              });
                        }, icon: const Icon(Icons.menu,color: Colors.white,))
                      ],
                    ),
                  );
                },
                itemCount: todoList.length,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                SizedBox(
                  width: screenSize.width * 0.8,
                  height: screenSize.height * 0.07,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      controller: inputText,
                      decoration: InputDecoration(
                        labelText: 'やることを入力してください',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: screenSize.width * 0.2,
                  height: screenSize.height * 0.07,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue, shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: const BorderSide(
                          color: Colors.blue
                        ),
                      ),
                      onPressed: () {
                        final v = inputText.text;
                        setState(() {
                          getList.setList(v);
                          todoList.add({'content': v, 'isFinish': "false"});
                          inputText.clear();
                        });
                      },
                      child: const Text('追加'),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  isFalse(b){
    if(b == "false"){
      return false;
    }else{
      return true;
    }
  }
}
