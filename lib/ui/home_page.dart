import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TodoItem> _items = [
    TodoItem(title: "Eat"),
    TodoItem(title: "Sleep"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Icon(
            Icons.menu,
            color: Color(0xFF433D82),
          ),
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _buildBodyContent(context),
          flex: 1,
        ),
        _buildAddButton(),
      ],
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _buildHelloWidget(context: context, name: 'Human'),
          ),
          SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _buildDateWidget(context: context),
          ),
          SizedBox(height: 20.0),
          Divider(height: 1),
          SizedBox(height: 4.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: _buildTaskTypesWidget(context: context),
          ),
          SizedBox(height: 4.0),
          Divider(height: 1),
          _buildListView(context)
        ],
      ),
    );
  }

  Widget _buildHelloWidget(
      {@required BuildContext context, @required String name}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Hello,',
          style: Theme.of(context).textTheme.display1.copyWith(
                color: Color(0xFF433D82),
                fontSize: 24,
              ),
        ),
        Text(
          '$name',
          style: Theme.of(context).textTheme.display2.copyWith(
                color: Color(0xFF433D82),
                fontWeight: FontWeight.w700,
                fontSize: 48,
              ),
        ),
      ],
    );
  }

  Widget _buildDateWidget({@required BuildContext context}) {
    return RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xFF878695),
        ),
        children: <TextSpan>[
          TextSpan(
            text: DateFormat("EEEEE", "en_US").format(DateTime.now()) + ', ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: DateFormat.yMMMMd("en_US").format(DateTime.now()),
            style: TextStyle(),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskTypesWidget({@required BuildContext context}) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      _buildToggleButton(
          context: context, text: "All", onPressed: () {}, focus: true),
      _buildToggleButton(context: context, text: "Active", onPressed: () {}),
      _buildToggleButton(context: context, text: "Completed", onPressed: () {}),
    ]);
  }

  Widget _buildToggleButton(
      {@required BuildContext context,
      @required String text,
      @required Function() onPressed,
      bool focus = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: ButtonTheme(
        minWidth: 0,
        child: FlatButton(
          child: Text(text),
          onPressed: onPressed,
          shape: focus
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                  side: BorderSide(color: Colors.grey.shade400))
              : null,
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: _items.length,
        itemBuilder: (context, i) {
          return _buildListTile(
            context: context,
            index: i,
          );
        },
      ),
    );
  }

  Widget _buildListTile({@required BuildContext context, int index}) {
    TodoItem item = _items[index];
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(0, 2, 0, 2),
      leading: Checkbox(
        onChanged: (b) {},
        value: false,
      ),
      title: Text(
        item.title,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.red,
        ),
        onPressed: () {},
      ),
    );
  }

  Widget _buildAddButton() {
    InputBorder border =
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent));
    return Container(
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(width: 1, color: Colors.grey.shade300))),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: TextFormField(
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    hintText: "What needs to be done?",
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                    contentPadding: EdgeInsets.fromLTRB(
                        16, 16, 16, MediaQuery.of(context).padding.bottom)),
              ),
            ),
          ),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0)),
              child: MaterialButton(
                height: 55.0 + MediaQuery.of(context).padding.bottom,
                minWidth: 65.0,
                child: Icon(Icons.add, color: Colors.white),
                color: Color(0xFFFF4954),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TodoItem {
  String title;
  bool isCompleted;
  TodoItem({@required this.title, this.isCompleted = false});
}