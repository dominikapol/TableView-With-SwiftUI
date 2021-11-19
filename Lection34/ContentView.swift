//
//  ContentView.swift
//  Lection34
//
//  Created by Vladislav on 17.11.21.
//

import SwiftUI

struct Task: Identifiable, Hashable {
    let id = UUID()
    
    var name: String
    var date: String
}

struct ContentView: View {
    @State var tasks: [Task] = [Task(name: "Hello World!", date: "19/11/2021")]
    @State var shouldShowTextFieldAlert: Bool = false
    @State var selectedTask: Task?
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text(selectedTask?.name ?? "Select task")
                List(
                    selection: $selectedTask,
                    content: {
                        ForEach(tasks, id: \.self) { task in
                            TaskView(
                                name: task.name,
                                date: task.date
                            ).onTapGesture {
                                print(task)
                            }
                        }.onDelete { index in
                            tasks.remove(atOffsets: index)
                        }
                    })
                    .padding()
                    .navigationTitle("Task")
                    .toolbar {
                        EditButton()
                    }
                Button(
                    "Add Task",
                    action: {
                        shouldShowTextFieldAlert = true
                    }
                ).frame(height: 50.0)
                    .background(Color.orange).cornerRadius(10).foregroundColor(Color.black).padding(.bottom, 10).padding(.leading, 10).padding(.trailing, 10)
                    .alert(
                        isPresented: $shouldShowTextFieldAlert,
                        TextAlert(
                            title: "Enter task name",
                            message: "Please enter task name"
                        ) { result in
                            if let name = result {
                                createTask(name: name)
                            } else {
                                // The dialog was cancelled
                            }
                        }
                    )
            }
        }
    }
    
    private func createTask(name: String) {
        let date = Date().formatted(
            .dateTime
                .month(.wide)
                .day(.twoDigits)
                .year()
        )
        let task = Task(name: name, date: date)
        tasks.append(task)
    }
        
}

struct TaskView: View {
    @State var name: String
    @State var date: String
    
    var body: some View {
        VStack {
            Text(name)
            Text(date)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
