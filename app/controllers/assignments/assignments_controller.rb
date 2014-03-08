class Assignments::AssignmentsController < AuthenticatedController
  def index
    @assignments = current_user.assignments.joins(:task).where("tasks.open" => true)
  end
  def all
    @assignments = current_user.assignments.includes(:task)
  end
end
