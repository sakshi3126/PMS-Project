class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, :dependent => :delete_all

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :due_date

  enum status: {
      'Complete': 1,
      'Progress': 2,
      'Active': 0

  }
  after_initialize :set_defaults, if: :new_record?

  def set_defaults
    self.status = "Active"
  end

  accepts_nested_attributes_for :tasks, reject_if: lambda { |attributes| attributes['name'].blank? }, allow_destroy: true
end
