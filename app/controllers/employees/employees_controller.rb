class Employees::EmployeesController < ApplicationController
  def index
    authorize! :read, User
    @users = User.all
  end
  
  def new
    authorize! :create, User
    @user = User.new
    @url = employees_path
  end
  
  def create
  end
end
