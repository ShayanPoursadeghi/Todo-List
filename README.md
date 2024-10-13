<h1>📋 Todo List App</h1>

This Todo List App is a Flutter application that allows users to create, edit, and manage their tasks efficiently. It also supports searching tasks, filtering based on input, deleting all tasks, and more. The app uses Hive for local storage of tasks and BLoC (Business Logic Component) for state management. This is a great starter app for keeping track of your daily tasks!

<h2>📱 Features</H2>
Add new tasks with a priority (low, normal, high).
Edit existing tasks.
Search for tasks using a search bar.
Mark tasks as complete or incomplete.
Delete individual tasks or delete all tasks at once.
Tasks are persisted locally using Hive so they are retained even after closing the app.
Smooth UI with a confirmation dialog before deleting a task.

<h2>📂 Folder Structure</h2>
<pre>lib/
├── data/
│   ├── repo/
│   │   └── repository.dart     # Handles repository logic for tasks
│   ├── source/
│   │   ├── hive_task_source.dart  # Handles Hive data source operations
│   │   ├── source.dart            # Abstract DataSource class for CRUD operations
│   ├── data.dart                # Task and Priority entity definitions
│   ├── data.g.dart              # Auto-generated Hive adapters
│
├── screens/
│   ├── edit/
│   │   └── edit.dart            # Screen for creating or editing tasks
│   ├── home/
│   │   ├── home.dart            # Main screen with task list, search, and delete functionality
│   │   ├── bloc/
│   │   │   ├── task_list_bloc.dart  # BLoC for managing state of tasks
│   │   │   ├── task_list_event.dart # BLoC events (Task creation, deletion, search)
│   │   │   └── task_list_state.dart # BLoC states (Success, Error, Empty, Loading)
│
├── main.dart                    # Entry point for the Flutter app
├── widgets.dart                 # Custom UI widgets such as TaskItem, EmptyState, etc.
</pre>

<h2>🚀 Getting Started</h2>
<h3>Prerequisites</h3>
To run the project, ensure you have the following installed:

- Flutter SDK
- Dart SDK
- Hive (for local storage)
- Provider (for dependency injection)
- BLoC (for state management)

<h3>Installation</h3>
1. Clone the repository:

```bash
git clone https://github.com/ShayanPoursadeghi/Todo-List.git
cd todo-list-app 
```
    
2. Install the dependencies:

```bash
flutter pub get
```

3. Set up Hive for the project:

```bash
flutter packages pub run build_runner build
```

4. Run the app:

```bash
flutter run
```

<h2>🛠 Technologies Used</h2>

- **Flutter**: For building the UI and handling app logic.
- **Hive**: Lightweight and fast NoSQL database used for storing tasks locally.
- **BLoC (Business Logic Component)**: For managing state and logic in a clear, scalable way.
- **Provider**: For dependency injection, helping manage state across the app.
- **Google Fonts**: For custom typography in the app.

<h2>🧩 BLoC Architecture Overview</h2>
This project follows the BLoC architecture pattern to separate business logic from the UI layer. Here's how the BLoC structure works:

- **Events**: Users' actions (e.g., searching for tasks, deleting tasks) are turned into events like TaskListSearch and TaskListDeleteAll.
- **States**: The app reacts to events by emitting new states such as TaskListLoading, TaskListSuccess, TaskListEmpty, etc.
- **BLoC (task_list_bloc.dart)**: Contains all the logic that reacts to events and emits states. It works as the "middle-man" between the UI and the data source.

<h2>🗃️ Hive Integration</h2>
The app uses Hive for storing tasks locally in a fast, key-value store. The following entities are stored in Hive:

- **TaskEntity**: Each task that the user creates is stored with an ID, name, priority, and completed status.
- **Priority**: Represents the priority of the task (low, normal, or high).

<h2>💡 Features Breakdown</h2>
<h3>Adding a Task</h3>
You can add new tasks by clicking the Add New Task button. Tasks are saved with a priority and name, and they persist in the local storage using Hive.

<h3>Searching for Tasks</h3>
The search bar allows users to filter tasks by typing in keywords. The app uses BLoC to handle the search and update the UI with the filtered tasks.

<h3>Deleting Tasks</h3>
To delete a task, long-press the task item. The app will ask for confirmation before permanently removing it from the list.

<h3>Marking Tasks as Complete</h3>
By clicking the checkbox next to each task, the user can toggle the completion status of a task. The state of the task is immediately saved in Hive and reflected in the UI.

<h2>🖼️ Screenshots</h2>

|       **Home Screen**                     |       **Add/Edit Task Screen**                               |      **Filtering tasks by search**                     |

| <img src="screenshots/home_screen.png" width="300"/> | <img src="screenshots/add-edit_screen.png" width="300"/> | <img src="screenshots/search.png" width="300"/> |


<h2>👨‍💻 Contributing</h2>
Feel free to fork this repository and contribute by submitting a pull request. Any contributions, whether they're bug fixes or new features, are welcome.

<h2>📄 License</h2>
This project is licensed under the MIT License - see the LICENSE file for details. 


<h2>📧 Contact</h2>
For questions, feel free to reach out to me at [sh.psadeghi@gmail.com](mailto:sh.psadeghi@gmail.com). 

