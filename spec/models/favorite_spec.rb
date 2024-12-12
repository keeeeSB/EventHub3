require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category) }
  let(:event) { FactoryBot.build(:event, user: user, category: category) }
  let(:favorite) { FactoryBot.build(:favorite, user: user, event: event) }

  describe "アソシエーションのテスト" do
    it "ユーザーに属している" do
      expect(Favorite.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it "イベントに属している" do
      expect(Favorite.reflect_on_association(:event).macro).to eq(:belongs_to)
    end
  end
end
