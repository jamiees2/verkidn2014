class Assignments::AssignmentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @assignments = current_user.assignments.joins(:task).where("tasks.open" => true)
  end
  def all
    @assignments = current_user.assignments.includes(:task)
  end
end
