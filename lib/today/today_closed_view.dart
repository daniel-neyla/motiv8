// Widget todayClosedView({
//     required Widget summary,
//     required VoidCallback onStartTomorrow,
//     required VoidCallback onAddTask,
//   }) {
//     return SafeArea(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 18),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(height: 24),
//             Expanded(child: summary),
//             SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: onStartTomorrow,
//               child: Text('Start Tomorrow'),
//             ),
//             SizedBox(height: 12),
//             OutlinedButton(
//               onPressed: onAddTask,
//               child: Text('Add Task for Tomorrow'),
//             ),
//             SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }
