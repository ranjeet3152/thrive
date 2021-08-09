class UsersController < ApplicationController
  require 'csv'
  def index
    @users = User.all
    # UploadUserFileJob.perform_later('123')
  end

  # def import
  #   @incoming_file = params[:file]
  #   user_id = 1
  #   FileUtils.mv @incoming_file.tempfile, "/home/dell/Documents/thrive/temp_file/user_#{user_id}"
  #   UploadUserFileJob.perform_later("/home/dell/Documents/thrive/temp_file/user_#{user_id}")
  #   redirect_to documents_path, notice: 'Data Imported Sucessfully'
  # end
end
