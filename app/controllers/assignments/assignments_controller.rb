class Assignments::AssignmentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @assignments = current_user.assignments.includes(:task)
  end
end
