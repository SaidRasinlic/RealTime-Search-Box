class SearchCountsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "search_counts"
  end
end
