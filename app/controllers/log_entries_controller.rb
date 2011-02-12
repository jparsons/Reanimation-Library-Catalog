class LogEntriesController < ApplicationController
  def index
    if params[:after_id].blank?
      @log_entries = LogEntry.find_all_by_process_log_id(params[:process_log_id])
    else
      @log_entries = LogEntry.find(:all, :conditions=>["process_log_id=? and id > ?", params[:process_log_id], params[:after_id]])
    end
    
    respond_to do |wants|
      wants.html {  }
    end
  end

end