class Assignments::ListController < ApplicationController
  before_action :authenticate_user!
  def index
    @work_parts = current_user.work_parts
  end
end
