class Manage::AssignmentsController < Manage::ApplicationController

  before_filter :find_work
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  def index
    authorize! :read, Assignment
    @assignments = @work_part.assignments
  end

  # GET /works/1
  # GET /works/1.json
  def show
    authorize! :read, Assignment
  end

  # GET /works/new
  def new
    authorize! :create, Assignment
    @assignment = Assignment.new
  end

  # GET /works/1/edit
  def edit
    authorize! :update, Assignment
  end

  # POST /works
  # POST /works.json
  def create
    authorize! :create, Assignment
    @assignment = Assignment.new(assignment_params)
    @assignment.work_part = @work_part
    # @assignment.creator = current_user
    # @work_part.work = @work

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to work_work_part_assignment_path(@work,@work_part,@assignment), notice: 'WorkPart was successfully created.' }
        format.json { render action: 'show', status: :created, location: work_work_part_assignment_url(@work,@work_part,@assignment) }
      else
        format.html { render action: 'new' }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /works/1
  # PATCH/PUT /works/1.json
  def update

    authorize! :update, Assignment
    respond_to do |format|
      if @work_part.update(work_params)
        format.html { redirect_to work_work_part_assignment_path(@work,@work_part,@assignment), notice: 'WorkPart was successfully updated.' }
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
    authorize! :destroy, Assignment
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to work_work_part_assignments_path(@work,@work_part) }
      format.json { head :no_content }
    end
  end

  private
  def find_work
    @work = Work.find(params[:work_id])
    @work_part = @work.work_parts.find(params[:work_part_id])
  end
  def set_assignment
    @assignment = @work_part.assignments.find(params[:id])
  end
  def assignment_params
    params.require(:assignment).permit(:user_id)
  end
end
