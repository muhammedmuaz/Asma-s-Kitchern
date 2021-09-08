import 'package:flutter/material.dart';

class bottom_counter extends StatelessWidget {
  final Map data;
  bottom_counter({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 80,
            backgroundImage: NetworkImage(data['image']),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: ListTile(
              leading: Text(
                data['text'],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                data['Price'],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, bottom: 30),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.white,
                ),
                Icon(
                  Icons.star,
                  color: Colors.white,
                ),
                Icon(
                  Icons.star,
                  color: Colors.white,
                ),
                Icon(
                  Icons.star,
                  color: Colors.white,
                ),
                Icon(
                  Icons.star,
                  color: Colors.white,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
