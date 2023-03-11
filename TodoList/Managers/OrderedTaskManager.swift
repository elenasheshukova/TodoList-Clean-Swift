//
//  OrderedTaskManager.swift
//  TodoList
//
//  Created by Kirill Leonov on 20.02.2023.
//

import Foundation

/// Предоставляет список заданий, отсортированных по приоритету.
final class OrderedTaskManager: ITaskManager {
	let taskManager: ITaskManager

	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}

	func allTasks() -> [Task] {
		sorted(tasks: taskManager.allTasks())
	}

	func completedTasks() -> [Task] {
		sorted(tasks: taskManager.completedTasks())
	}

	func uncompletedTasks() -> [Task] {
		sorted(tasks: taskManager.uncompletedTasks())
	}

	func addTasks(tasks: [Task]) {
		taskManager.addTasks(tasks: tasks)
	}

	private func sorted(tasks: [Task]) -> [Task] {
		tasks.sorted {
			if let task0 = $0 as? ImportantTask, let task1 = $1 as? ImportantTask {
				return task0.taskPriority.rawValue > task1.taskPriority.rawValue
			}

			if $0 is ImportantTask, $1 is RegularTask {
				return true
			}

			if  $0 is RegularTask, $1 is ImportantTask {
				return false
			}

			return true
		}
	}
}
