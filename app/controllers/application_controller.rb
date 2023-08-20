class ApplicationController < ActionController::Base
  before_action :set_user_cookie

  def record_search(query)
    if current_user
      current_user.search_logs.create(query: query)
    end
  end

  def current_user
    @current_user ||= User.find_by(id: cookies.signed[:user_id])
  end

  def destroy_user_cookie
    cookies.delete(:user_id)
    redirect_back(fallback_location: root_path)
  end

  helper_method :current_user

  private

  def set_user_cookie
    unless cookies.signed[:user_id]
      user = User.create! # No need to specify ID
      cookies.permanent.signed[:user_id] = user.id
    end
end
end