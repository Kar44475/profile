// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class newss
// {
//   String name;
//   newss(this.name);
// }

// // simple provider example
// final newProvider = Provider<String>((ref) {
//   int s =10;
//   return 'hai'+s.toString();
// });

// final newProvider1 = Provider.family<String, int>((ref, arg) {
//   if (arg == 1) {
//     return 'hai';
//   } else {
//     return 'hello';
//   }
// });

// final newProvider2 = StateProvider<newss>((ref) {
//   return newss('initial');
// });


// class NewsNotifier extends StateNotifier<newss> {
//   NewsNotifier() : super(newss('initial'));

//   // Update the name
//   void updateName(String newName) {
//     state = newss(newName);
//   }

//   // Reset to initial
//   void reset() {
//     state = newss('initial');
//   }

//   // Append text to name
//   void appendToName(String text) {
//     state = newss(state.name + text);
//   }

//   // Simulate async fetch and update
//   Future<void> fetchAndUpdate() async {
//     await Future.delayed(Duration(seconds: 1));
//     state = newss('fetched');
//   }
// }

// final newProvider3 = StateNotifierProvider<NewsNotifier, newss>((ref) => NewsNotifier());