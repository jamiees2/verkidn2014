class Manage::WorkPartsController < Manage::ApplicationController

  before_filter :find_work
  before_action :set_work_part, only: [:show, :edit, :update, :destroy]
  def index
    authorize! :read, WorkPart
    @work_parts = @work.work_parts
  end

  # GET /works/1
  # GET /works/1.json
  def show
    authorize! :read, WorkPart
  end

  # GET /works/new
  def new
    @work_part = WorkPart.new
    authorize! :create, @work_part
    @url = work_work_parts_path(@work)
  end

  # GET /works/1/edit
  def edit
    @url = work_work_part_path(@work,@work_part)
    authorize! :update, @work_part
  end

  # POST /works
  # POST /works.json
  def create
    authorize! :create, WorkPart
    @work_part = WorkPart.new(work_part_params)
    @work_part.creator = current_user
    @work_part.work = @work

    respond_to do |format|
      if @work_part.save
        format.html { redirect_to work_work_part_path(@work,@work_part), notice: 'WorkPart was successfully created.' }
        format.json { render action: 'show', status: :created, location: work_work_part_url(@work,@work_part) }
      else
        format.html { render action: 'new' }
        format.json { render json: @work_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /works/1
  # PATCH/PUT /works/1.json
  def update

    authorize! :update, @work_part
    respond_to do |format|
      if @work_part.update(work_part_params)
        format.html { redirect_to work_work_part_path(@work,@work_part), notice: 'WorkPart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @work_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.json
  def destroy
    authorize! :destroy, WorkPart
    @work_part.destroy
    respond_to do |format|
      format.html { redirect_to work_work_parts_url(@work) }
      format.json { head :no_content }
    end
  end

  private
  def find_work
    @work = Work.find(params[:work_id])
  end
  def set_work_part
    @work_part = @work.work_parts.find(params[:id])
  end
  def work_part_params
    params.require(:work_part).permit(:name,:description)
  end
end
