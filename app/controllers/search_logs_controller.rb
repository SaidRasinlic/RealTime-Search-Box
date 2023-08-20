# app/controllers/search_logs_controller.rb
class SearchLogsController < ApplicationController

  def index
    @search_logs = current_user.search_logs.group(:query).count
    @most_searched_query = @search_logs.max_by { |_, count| count }&.first
    update_search_counts

  end

  def record_search(query)
    if current_user
      current_user.search_logs.create(query: query)
      update_search_counts
    end
  end
  def update_search_counts
    user_id = params[:user_id]
    query = params[:query]
    matching_count = params[:matching_count]
    non_matching_count = params[:non_matching_count]

    # Update the search log for the user with the matching and non-matching counts
    search_log = current_user.search_logs.find_by(query: query)
    if search_log
      search_log.update(matching_count: matching_count, non_matching_count: non_matching_count)
    end

    render json: { success: true }
  end
  
end

  
