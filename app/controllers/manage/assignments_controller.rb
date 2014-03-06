class Manage::AssignmentsController < Manage::ApplicationController

  before_filter :find_project
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  def index
    authorize! :read, Assignment
    @assignments = @task.assignments
  end

  # GET /works/1
  # GET /works/1.json
  def show
    authorize! :read, @assignment
  end

  # GET /works/new
  def new
    authorize! :create, Assignment
    @assignment = Assignment.new
    @url = project_task_assignments_path(@project,@task)
  end

  # GET /works/1/edit
  def edit
    authorize! :update, @assignment
    @url = project_task_assignment_path(@project,@task,@assignment)
  end

  # POST /works
  # POST /works.json
  def create
    authorize! :create, Assignment
    @assignment = Assignment.new(assignment_params)
    @assignment.task = @task
    # @assignment.creator = current_user
    # @task.work = @work

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to project_task_assignment_path(@project,@task,@assignment), notice: 'WorkPart was successfully created.' }
        format.json { render action: 'show', status: :created, location: project_task_assignment_url(@project,@task,@assignment) }
      else
        format.html { render action: 'new' }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /works/1
  # PATCH/PUT /works/1.json
  def update

    authorize! :update, @assignment
    respond_to do |format|
      if @task.update(assignment_params)
        format.html { redirect_to project_task_assignment_path(@project,@task,@assignment), notice: 'WorkPart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.json
  def destroy
    authorize! :destroy, @assignment
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to project_task_assignments_path(@project,@task) }
      format.json { head :no_content }
    end
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:task_id])
  end
  def set_assignment
    @assignment = @task.assignments.find(params[:id])
  end
  def assignment_params
    params.require(:assignment).permit(:user_id)
  end
end
