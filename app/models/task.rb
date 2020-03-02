class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :task_status
  validates_presence_of :task_date

  enum task_status: {
      'Done': 1,
      'Progress': 2,
      'To Do': 0,
  }
  enum priority: {
      'High': 1,
      'Low': 2,
      'Medium': 3
  }
end                                               
