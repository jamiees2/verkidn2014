class Assignments::WorklogController < ApplicationController
  before_action :authenticate_user!
  before_filter :find_assignment
  before_action :set_work_log, only: [:show, :edit, :update, :destroy]
  def index
    authorize! :read, WorkLog
    @work_logs = @assignment.work_logs
    @num_hours = @work_logs.sum(&:hours) || 0
  end

  # GET /works/1
  # GET /works/1.json
  def show
    authorize! :read, WorkLog
  end

  # GET /works/new
  def new
    authorize! :create, WorkLog
    @url = assignment_worklog_index_path(@assignment)
    @work_log = WorkLog.new
  end

  # GET /works/1/edit
  def edit
    authorize! :update, WorkLog
    @url = assignment_worklog_path(@assignment,@work_log)
  end

  # POST /works
  # POST /works.json
  def create
    authorize! :create, WorkLog
    @work_log = WorkLog.new(work_log_params)
    @work_log.assignment = @assignment
    respond_to do |format|
      if @work_log.save
        format.html { redirect_to assignment_worklog_index_path(@assignment), notice: 'Work was successfully created.' }
        format.json { render action: 'show', status: :created, location: assignment_worklog_index_url(@assignment) }
      else
        format.html { render action: 'new' }
        format.json { render json: @work_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /works/1
  # PATCH/PUT /works/1.json
  def update

    authorize! :update, WorkLog
    respond_to do |format|
      if @work_log.update(work_log_params)
        format.html { redirect_to @work_log, notice: 'Work was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @work_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.json
  def destroy
    authorize! :destroy, WorkLog
    @work_log.destroy
    respond_to do |format|
      format.html { redirect_to assignment_worklog_index_path(@assignment) }
      format.json { head :no_content }
    end
  end
  private
    def find_assignment
      @assignment = Assignment.find(params[:assignment_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_work_log
      @work_log = @assignment.work_logs.find(params[:id])
    end

    def work_log_params
      params.require(:work_log).permit(:hours,:description)
    end
end
