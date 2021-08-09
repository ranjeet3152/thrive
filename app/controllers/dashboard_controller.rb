class DashboardController < ApplicationController
  def index
    @admin = Admin.last
  end

  def upload_users
    respond_to do |format|
      format.html { render layout: 'upload_files' }
    end
  end
end
