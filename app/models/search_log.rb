class SearchLog < ApplicationRecord
  belongs_to :user

  def self.most_searched_query
    most_searched_query_counts = group(:query).order(Arel.sql('COUNT(*) DESC')).limit(1).pluck(:query)
    most_searched_query_counts.first
  end

  def self.query_count(query)
    where(query: query).count
  end
  

  def self.most_searched_query_per_user_today(user)
    result = where(user: user, created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
      .group(:query)
      .order(Arel.sql('COUNT(*) DESC'))
      .limit(1)
      .pluck(:query, Arel.sql('COUNT(*)'))
      .first

    { query: result[0], count: result[1] } if result
  end

  def self.most_searched_query_and_count_per_user(user)
    result = where(user: user).group(:query).order(Arel.sql('COUNT(*) DESC')).limit(1).pluck(:query, Arel.sql('COUNT(*) AS count')).first
    { query: result[0], count: result[1] }
  end

  def self.most_searched_query_globally
    result = group(:query).order(Arel.sql('COUNT(*) DESC')).limit(1).pluck(:query, Arel.sql('COUNT(*) AS count')).first
    if result
      { query: result[0], count: result[1] }
    else
      { query: nil, count: 0 } # Default values if result is nil
    end
  end

  def self.most_searched_query_count_globally(query)
    where(query: query).count
  end
end
