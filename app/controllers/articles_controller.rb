# app/controllers/articles_controller.rb
class ArticlesController < ApplicationController
  def index
    @search_logs = current_user.search_logs.group(:query).count
  
    @most_searched_query = SearchLog.most_searched_query
    @most_searched_count = SearchLog.query_count(@most_searched_query)
    @most_searched_query_and_count_per_user = SearchLog.most_searched_query_and_count_per_user(current_user)

    @most_searched_data_globally = SearchLog.most_searched_query_globally
    @most_searched_query_today = SearchLog.most_searched_query_per_user_today(current_user)
    @chart_data = current_user.search_logs.group(:query).count

    @chart_data_group_by_day_of_week = current_user.search_logs
    .group("EXTRACT(DOW FROM created_at)")
    .count
    .transform_keys { |dow| Date::ABBR_DAYNAMES[dow.to_i] }

    @matching_search_logs_count = 0
    @non_matching_search_logs_count = 0
    
    # Get all search logs for the current user
    search_logs = current_user.search_logs
    
    # Loop through each search log
    search_logs.each do |search_log|
      # Check if the query matches any article title
      matching_article = Article.find_by(title: search_log.query)
    
      if matching_article
        # If a matching article is found, increment the matching count
        @matching_search_logs_count += 1
      else
        # If no matching article is found, increment the non-matching count
        @non_matching_search_logs_count += 1
      end
    end

end

  def search
    query = params[:q]
    @articles = Article.where("title LIKE ?", "%#{query}%")

    if current_user
      current_user.search_logs.create(query: query)
    end

    render json: @articles
  end

  def update_search_counts
    @most_searched_query_and_count_per_user = SearchLog.most_searched_query_and_count_per_user(current_user)

    @most_searched_data_globally = SearchLog.most_searched_query_globally
    @most_searched_query_today = SearchLog.most_searched_query_per_user_today(current_user)

    @matching_search_logs_count = 0
    @non_matching_search_logs_count = 0

    # Get all search logs for the current user
    search_logs = current_user.search_logs

    # Loop through each search log
    search_logs.each do |search_log|
      # Check if the query matches any article title
      matching_article = Article.find_by(title: search_log.query)

      if matching_article
        # If a matching article is found, increment the matching count
        @matching_search_logs_count += 1
      else
        # If no matching article is found, increment the non-matching count
        @non_matching_search_logs_count += 1
      end
    end

    render json: { 
      matching_count:  @matching_search_logs_count,
      non_matching_count:  @non_matching_search_logs_count,
      most_searched_query_and_count_per_user: @most_searched_query_and_count_per_user,
      most_searched_data_globally: @most_searched_data_globally,
      most_searhed_query_today: @most_searched_query_today
    }

    ActionCable.server.broadcast("search_counts", {most_searched_data_globally: @most_searched_data_globally})
    # head :ok
  end

end