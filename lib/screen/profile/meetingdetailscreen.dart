
// import 'package:bmitserp/widget/radialDecoration.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:provider/provider.dart';

// class MeetingDetailScreen extends StatefulWidget {
//   static const routeName = '/meetingdetailscreen';

//   @override
//   State<StatefulWidget> createState() => MeetingDetailState();
// }

// class MeetingDetailState extends State<MeetingDetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // final args = ModalRoute.of(context)!.settings.arguments as int;
//     //final item = Provider.of<MeetingProvider>(context)
//     //     .meetingList
//     //     .where((item) => item.id == args)
//     //     .first;
//     return Container(
//       decoration: RadialDecoration(),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           title: Text('Meeting Detail'),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.baseline,
//               textBaseline: TextBaseline.alphabetic,
//               children: [
//                 ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.network(
//                       //item.image,
//                       '',
//                       height: 200,
//                       fit: BoxFit.cover,
//                       width: MediaQuery.of(context).size.width,
//                     )),
//                 gaps(10),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Icon(
//                       Icons.location_on,
//                       size: 20,
//                       color: Colors.white,
//                     ),
//                     Text(
//                       // item.venue,
//                       'venue',
//                       style: TextStyle(color: Colors.white, fontSize: 15),
//                     )
//                   ],
//                 ),
//                 gaps(10),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Text(
//                     //item.title,
//                     'title',
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                 ),
//                 gaps(10),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Text(
//                     //'Date - ${item.meetingDate} ${item.meetingStartTime}',
//                     'date',

//                     style: TextStyle(color: Colors.white, fontSize: 15),
//                   ),
//                 ),
//                 gaps(10),
//                 // Html(
//                 //   style: {
//                 //     "body": Style(
//                 //         color: Colors.white70,
//                 //         fontSize: FontSize.large,
//                 //         textAlign: TextAlign.justify)
//                 //   },
//                 //   data: item.agenda,
//                 // ),
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Text(
//                     'Participants',
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                 ),
//                 gaps(10),
//                 ListView.separated(
//                     primary: false,
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 2.0),
//                         child: ListTile(
//                           title: Text(
//                             //item.participator[index].name,
//                             'name',
//                             style: TextStyle(fontSize: 15),
//                           ),
//                           trailing: Text(
//                             //  item.participator[index].post,
//                             'post',
//                             style: TextStyle(fontSize: 15),
//                           ),
//                           textColor: Colors.white,
//                           leading: ClipRRect(
//                             borderRadius: BorderRadius.circular(20),
//                             child: Image.network(
//                               //item.participator[index].avatar,
//                               'avatar',
//                               height: 40,
//                               width: 40,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                     separatorBuilder: (context, index) {
//                       return Divider(
//                         height: 1,
//                         indent: 20,
//                         endIndent: 20,
//                         color: Colors.white12,
//                       );
//                     },
//                     // itemCount: item.participator.length)
//                     itemCount: 1)
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget gaps(int value) {
//     return const SizedBox(
//       height: 10,
//     );
//   }
// }
