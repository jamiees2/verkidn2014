class Employees::WorklogController < AuthenticatedController
  before_filter :find_user
  before_action :set_work_log, only: [:show, :edit, :update, :destroy]
  def index
    authorize! :read, WorkLog
    @work_logs = @user.work_logs
    @num_hours = @work_logs.sum(&:hours) || 0
  end
  private
    def find_user
      @user = User.find(params[:employee_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_work_log
      @work_log = @user.assignment.work_logs.find(params[:id])
    end
end
