class Manage::WorksController < Manage::ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /works
  # GET /works.json
  def index
    authorize! :read, Work
    @works = Work.includes(:status)
  end

  # GET /works/1
  # GET /works/1.json
  def show
    authorize! :read, Work
  end

  # GET /works/new
  def new
    authorize! :create, Work
    @url = works_path
    @work = Work.new
  end

  # GET /works/1/edit
  def edit
    authorize! :update, Work
    @url = work_path(@work)
  end

  # POST /works
  # POST /works.json
  def create
    authorize! :create, Work
    @work = Work.new(work_params)
    @work.creator = current_user

    respond_to do |format|
      if @work.save
        format.html { redirect_to @work, notice: 'Work was successfully created.' }
        format.json { render action: 'show', status: :created, location: @work }
      else
        format.html { render action: 'new' }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /works/1
  # PATCH/PUT /works/1.json
  def update

    authorize! :update, Work
    respond_to do |format|
      if @work.update(work_params)
        format.html { redirect_to @work, notice: 'Work was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.json
  def destroy
    authorize! :destroy, Work
    @work.destroy
    respond_to do |format|
      format.html { redirect_to works_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_params
      params.require(:work).permit(:name, :description, :status_id)
    end
end
