class GamePiece < ActiveRecord::Base
  attr_accessible :game_id, :image_url, :last_space, :name
  belongs_to :game
  has_many :users

  def total_mileage_on(date = Date.yesterday)
    date = DateTime.parse(date.to_s).to_date
    users.inject(0) do |sum, user|
      sum += user.mileage_on(date)
    end
  end

  def average_mileage_on(date = Date.yesterday)
    return 0 if users.none?
    total_mileage_on(date) / users.size
  end

end
