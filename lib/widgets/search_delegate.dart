import 'package:consultation_system_mobile/utils/colors.dart';
import 'package:consultation_system_mobile/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../screens/message_screen/message_screen.dart';

class SearchMessages extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions

    return [
      IconButton(
        onPressed: () {
          if (query != '') {
            close(context, null);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 1),
                content: Text('No Input. Cannot Procceed'),
              ),
            );
          }
        },
        icon: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading

    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return ListView.builder(itemBuilder: (context, index) {
      return ListTile(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MessageScreen()));
        },
        subtitle: TextRegular(
            text: 'IT Department', fontSize: 10, color: Colors.grey),
        title:
            TextRegular(text: 'Lorem Ipsum', fontSize: 12, color: Colors.black),
        trailing: const Icon(Icons.arrow_right),
        tileColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.all(5.0),
          child: CircleAvatar(
            minRadius: 25,
            maxRadius: 25,
            backgroundColor: greyAccent,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
        ),
      );
    });
  }
}
