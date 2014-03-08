class Employees::EmployeesController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  def index
    authorize! :read, User
    @users = User.all
  end
  
  def show
  end
  
  def new
    authorize! :create, User
    @user = User.new
    @url = employees_path
  end
  
  def edit
    authorize! :update, @user
    @url = employee_path(@user)
  end

  # POST /works
  # POST /works.json
  def create
    authorize! :create, User
    @user = User.new(employee_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to employees_path, notice: 'Employee was successfully created.' }
        format.json { render action: 'index', status: :created, location: employees_url }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /works/1
  # PATCH/PUT /works/1.json
  def update

    authorize! :update, @user
    respond_to do |format|
      if @user.update(employee_params)
        format.html { redirect_to @project, notice: 'Employee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.json
  def destroy
    authorize! :destroy, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to employees_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role_id)
    end
end
