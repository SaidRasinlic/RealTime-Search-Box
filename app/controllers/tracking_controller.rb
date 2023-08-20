class TrackingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :track_search

  def track_search
    user_id = params[:user_id]
    query = params[:query]
    record_search(query)  
    # Store the user's search activity in the database or perform any desired action
    SearchLog.create(user_id: user_id, query: query)
    head :no_content
  end
end