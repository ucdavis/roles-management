class Diary::DiaryController < ApplicationController
  # filter_access_to :all, :attribute_check => true
  # filter_access_to :index, :attribute_check => true, :load_method => :load_people
  respond_to :json

  def index
    @entries = DiaryEntry.order('created_at DESC').all.uniq{ |e| e.diary_uid_id }
    
    render 'diary/index'
  end

  def show
    @uid = DiaryUid.find_by_id(params[:uid_id])
    
    render 'diary/show'
  end
end
