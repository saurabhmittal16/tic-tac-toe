import 'package:flutter/material.dart';

String showResult(int playerNumber) {
    if (playerNumber == 0)
        return 'Tie';
    return 'Player $playerNumber wins!';
}

Widget getTile (int index, String text) {
	return Container(
		decoration: BoxDecoration(
			border: getBorders(index)
		),
		child: Center(
			child: Text(
				text,
				style: TextStyle(fontSize: 64, fontWeight: FontWeight.w400),  
			),
		)
	);
}

Border getBorders(int index) {
	switch (index) {
		case 0: return Border(
			bottom: BorderSide(width: 2, color: Colors.purple),
			right: BorderSide(width: 2, color: Colors.purple)
		);
		case 1: return Border(
			bottom: BorderSide(width: 2, color: Colors.purple),
			left: BorderSide(width: 2, color: Colors.purple),
			right: BorderSide(width: 2, color: Colors.purple)
		);
		case 2: return Border(
			bottom: BorderSide(width: 2, color: Colors.purple),
			left: BorderSide(width: 2, color: Colors.purple),
		);
		case 3: return Border(
			top: BorderSide(width: 2, color: Colors.purple),
			bottom: BorderSide(width: 2, color: Colors.purple),
			right: BorderSide(width: 2, color: Colors.purple)
		);
		case 4: return Border.all(width: 2, color: Colors.purple); 
		case 5: return Border(
			top: BorderSide(width: 2, color: Colors.purple),
			bottom: BorderSide(width: 2, color: Colors.purple),
			left: BorderSide(width: 2, color: Colors.purple),
		);
		case 6: return Border(
			top: BorderSide(width: 2, color: Colors.purple),
			right: BorderSide(width: 2, color: Colors.purple)
		);
		case 7: return Border(
			top: BorderSide(width: 2, color: Colors.purple),
			left: BorderSide(width: 2, color: Colors.purple),
			right: BorderSide(width: 2, color: Colors.purple)
		);
		case 8: return Border(
			top: BorderSide(width: 2, color: Colors.purple),
			left: BorderSide(width: 2, color: Colors.purple),
		);
	}
	return Border.all(width: 2, color: Colors.purple);
}