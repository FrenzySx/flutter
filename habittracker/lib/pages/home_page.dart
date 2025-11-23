import 'package:flutter/material.dart';
import 'package:habittracker/components/my_drawer.dart';
import 'package:habittracker/components/my_habit_tile.dart';
import 'package:habittracker/components/my_heatmap.dart';
import 'package:habittracker/database/habit_database.dart';
import 'package:habittracker/models/habit.dart';
import 'package:habittracker/util/habit_util.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // read the existing habits on app startup
    super.initState();
    context.read<HabitDatabase>().readHabits();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  // text controller
  final TextEditingController textController = TextEditingController();
  // create new habit
  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(hintText: "Create a new habit"),
        ),
        actions: [
          // save button
          MaterialButton(
            onPressed: () {
              // get the new habit name
              String newHabitName = textController.text.trim();
              // save to db
              if (newHabitName.isNotEmpty) {
                context.read<HabitDatabase>().addHabit(newHabitName);
              }

              // pop box
              Navigator.pop(context);

              // clear controller
              textController.clear();
            },
            child: const Text('Save'),
          ),

          // cancel button
          MaterialButton(
            onPressed: () {
              // pop box
              Navigator.pop(context);

              // clear controller
              textController.clear();
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  // check habit onf and off
  void checkHabitOnOff(bool? value, Habit habit) {
    // update habit completion status
    if (value != null) {
      context.read<HabitDatabase>().updateHabitCompletion(habit.id, value);
    }
  }

  // edit habit box
  void editHabitBox(Habit habit) {
    // set the controllers text to the habits current name
    textController.text = habit.name;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(controller: textController),
        actions: [
          // save button
          MaterialButton(
            onPressed: () {
              // get the new habit name
              String newHabitName = textController.text.trim();
              // save to db
              if (newHabitName.isNotEmpty) {
                context.read<HabitDatabase>().updateHabitName(
                  habit.id,
                  newHabitName,
                );
              }

              // pop box
              Navigator.pop(context);

              // clear controller
              textController.clear();
            },
            child: const Text('Save'),
          ),
          // cancekl button
          MaterialButton(
            onPressed: () {
              // pop box
              Navigator.pop(context);

              // clear controller
              textController.clear();
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  // delete habit box\
  void deleteHabitBox(Habit habit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Are you sure you want to delete ?"),
        actions: [
          // delete button
          MaterialButton(
            onPressed: () {
              context.read<HabitDatabase>().deleteHabit(habit.id);

              // pop box
              Navigator.pop(context);
            },
            child: const Text('delete'),
          ),
          // cancekl button
          MaterialButton(
            onPressed: () {
              // pop box
              Navigator.pop(context);

              // clear controller
              textController.clear();
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          // heatmap
          _buildHeatMap(),
          // habitlist
          _buildHabitList(),
        ],
      ),
    );
  }

  // build heatmap
  Widget _buildHeatMap() {
    // habit database
    final habitDatabase = context.watch<HabitDatabase>();
    // current habits
    List<Habit> currentHabits = habitDatabase.currentHabits;

    // return heat map ui
    return FutureBuilder<DateTime?>(
      future: habitDatabase.getFirstLaunchDate(),
      builder: (context, snapshot) {
        // once data is available
        if (snapshot.hasData) {
          return MyHeatmap(
            startDate: snapshot.data!,
            datasets: prepHeatMapDataset(currentHabits),
          );
        }
        // handle case is where no data is returned
        else {
          return Container();
        }
      },
    );
  }

  // build habit list
  Widget _buildHabitList() {
    // habit db
    final habitDatabase = context.watch<HabitDatabase>();
    // current habits
    List<Habit> currentHabits = habitDatabase.currentHabits;
    // return list of habits UI
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: currentHabits.length,
      itemBuilder: (context, index) {
        // get individual habits
        final habit = currentHabits[index];

        // check if the habit is completed today
        bool isCompletedToday = isHabitCompletedToday(habit.completedDays);

        // return habit title ui
        return MyHabitTile(
          isCompleted: isCompletedToday,
          text: habit.name,
          onChanged: (value) => checkHabitOnOff(value, habit),
          editHabit: (context) => editHabitBox(habit),
          deleteHabit: (context) => deleteHabitBox(habit),
        );
      },
    );
  }
}
