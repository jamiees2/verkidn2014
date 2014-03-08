class Manage::ProjectsController < AuthenticatedController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /works
  # GET /works.json
  def index
    authorize! :read, Project
    @projects = Project.includes(:status)
  end
  
  def status
    authorize! :read, Project
    @projects = Project.includes(:status).where(status_id: params[:status_id])
    render action: :index
  end

  # GET /works/1
  # GET /works/1.json
  def show
    authorize! :read, Project
  end

  # GET /works/new
  def new
    authorize! :create, Project
    @url = projects_path
    @project = Project.new
  end

  # GET /works/1/edit
  def edit
    authorize! :update, Project
    @url = project_path(@project)
  end

  # POST /works
  # POST /works.json
  def create
    authorize! :create, Project
    @project = Project.new(work_params)
    @project.creator = current_user

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        @url = projects_path
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /works/1
  # PATCH/PUT /works/1.json
  def update

    authorize! :update, Project
    respond_to do |format|
      if @project.update(work_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        @url = project_path(@project)
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.json
  def destroy
    authorize! :destroy, Project
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_params
      params.require(:project).permit(:name, :description, :status_id)
    end
end
