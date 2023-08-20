class SearchCountsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'search_counts_channel'
  end

  def update_search_counts(data)
    user_id = data['user_id']
    matching_count = data['matching_count']
    non_matching_count = data['non_matching_count']

    # Update counts based on data received

    # Broadcast the updated counts to all subscribed clients
    ActionCable.server.broadcast('search_counts_channel', {
      user_id: user_id,
      matching_count: matching_count,
      non_matching_count: non_matching_count
    })
  end
end
