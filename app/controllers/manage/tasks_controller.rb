class Manage::TasksController < Manage::ApplicationController

  before_filter :find_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    authorize! :read, Task
    @tasks = @project.tasks
  end

  # GET /works/1
  # GET /works/1.json
  def show
    authorize! :read, Task
  end

  # GET /works/new
  def new
    @task = Task.new
    authorize! :create, @task
    @url = project_tasks_path(@project)
  end

  # GET /works/1/edit
  def edit
    @url = project_task_path(@project,@task)
    authorize! :update, @task
  end

  # POST /works
  # POST /works.json
  def create
    authorize! :create, Task
    @task = Task.new(task_params)
    @task.creator = current_user
    @task.project = @project

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_task_path(@project,@task), notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: project_task_url(@project,@task) }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /works/1
  # PATCH/PUT /works/1.json
  def update

    authorize! :update, @task
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_task_path(@project,@task), notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.json
  def destroy
    authorize! :destroy, Task
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_tasks_url(@project) }
      format.json { head :no_content }
    end
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  end
  def set_task
    @task = @project.tasks.find(params[:id])
  end
  def task_params
    params.require(:task).permit(:name,:description)
  end
end
