class DocumentsController < ApplicationController
  def upload_users
  end

  def upload_transactions
    
  end

  def user_report
  end

  def transaction_report
  end

  def filter_data
    text = params[:text]
    @type = params[:type]
    current_time = Time.current.beginning_of_day
    if text == 'Yesterday'
      end_date = start_date = Time.current.beginning_of_day - 1.day
      prev_end_date = prev_start_date = current_time - 2.days
    elsif text == 'Last 7 Days'
      prev_end_date = start_date = current_time - 7.days
      end_date = current_time
      prev_start_date = current_time - 14.days
    elsif text == 'Last 30 Days'
      prev_end_date = start_date = current_time - 30.days
      end_date = current_time
      prev_start_date = current_time - 60.days
    elsif text == 'Last 90 Days'
      prev_end_date = start_date = current_time - 90.days
      end_date = current_time
      prev_start_date = current_time - 180.days
    else
      prev_end_date = start_date = current_time.beginning_of_year
      end_date = current_time
      prev_start_date = current_time.prev_year.beginning_of_year
    end
    report_stat(@type, start_date, end_date, prev_start_date, prev_end_date)
  end

  def import_user
    @incoming_file = params[:file]
    user_id = 1
    FileUtils.mv @incoming_file.tempfile, "/home/dell/Documents/thrive/temp_file/user_#{user_id}"
    UploadUserFileJob.perform_later("/home/dell/Documents/thrive/temp_file/user_#{user_id}")
    redirect_to documents_path, notice: 'Data Imported Sucessfully'
  end

  def import_transactions
    @incoming_file = params[:file]
    user_id = 1
    FileUtils.mv @incoming_file.tempfile, "/home/dell/Documents/thrive/temp_file/transactions_#{user_id}"
    UploadTransactionFileJob.perform_later("/home/dell/Documents/thrive/temp_file/transactions_#{user_id}")
    redirect_to documents_path, notice: 'Data Imported Sucessfully'
  end

  def destroy
  end

  private

  def report_stat(type, start_date, end_date, prev_start_date, prev_end_date)
    if type == 'user'
      current_user = User.where(created_at: start_date..end_date).size
      prev_user = User.where(created_at: prev_start_date..prev_end_date).size
      difference = current_user - prev_user
      @percent_diff = (difference % prev_user) * 100
    else
      current_transaction = Transaction.where(created_at: start_date..end_date).size
      prev_transaction = Transaction.where(created_at: prev_start_date..prev_end_date).size
      difference = current_transaction - prev_transaction
      @percent_diff = (difference % prev_transaction) * 100
    end
  end

  def document_params
    params.require(:documet).permit(:name, :attachment)
  end
end
