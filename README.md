The application is used to manage tasks and employees assigned to perform them. Each major task consists of smaller tasks to which employees can be assigned.
Logic

To use the application you must create an account. The application allows you to add new employees, delete existing employees and modify their skill level. You can also add new tasks and add subtasks to them. Each subtask has a minimum skill level. Employees can be added to each subtask only if the employee's skill level is greater than or equal to the subtask's skill level. In addition, each subtask and task can only be deleted if it is completed.
Database side

Each Manager has a one-to-many relationship with Task and Todo and Employee.
Each Task has a one-to many relationship with Todo and many-to-one relationship with Manager.
Each Todo has a many-to-one relationship with Task and Manager and many-to-many relationship with Employee.
Each Employee has a many-to-one relationship with Manager and many-to-many relationship with Todo.
