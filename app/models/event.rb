class Event < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :joins, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :start_time, presence: true
  validates :location, presence: true

  # 開催日時が過ぎていないイベント
  scope :upcoming, -> { where('start_time >= ?', Time.current) }
  # 人気順に並び替え
  # scope :popular, -> { left_joins(:joins)
                      #  .group(:id)
                      #  .order('COUNT(joins.id) DESC') }

  # 開催日時が過ぎたイベント
  scope :past,     -> { where('start_time < ?',  Time.current) }
  # レビューの平均順に並び替え
  # scope :avarage_reviews_rating, -> { left_joins(:reviews)
                              # .select('events.*, COALESCE(AVG(reviews.rating), 0) AS average_rating')
                              # .group('events.id')
                              # .order(average_rating: :desc)}
end
