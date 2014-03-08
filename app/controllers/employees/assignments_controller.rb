class Employees::AssignmentsController < ApplicationController
  before_action :authenticate_user!
  before_filter :find_user
  def index
    @assignments = @user.assignments.includes(:task)
  end
  private
    def find_user
      @user = User.find(params[:employee_id])
    end
end
