require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category) }
  let(:event) { FactoryBot.build(:event, user: user, category: category) }
  let(:review) { FactoryBot.build(:review, user: user, event: event) }

  describe "バリデーションのテスト" do
    it "有効なレビューを作成できる" do
      expect(review).to be_valid
    end

    it "レビュー内容が必須である" do
      review.body = nil
      expect(review).to_not be_valid
    end

    it "5つ星評価が必須である" do
      review.rating = nil
      expect(review).to_not be_valid
    end
  end

  describe "アソシエーションのテスト" do
    it "ユーザーに属している" do
      expect(Review.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it "イベントに属している" do
      expect(Review.reflect_on_association(:event).macro).to eq(:belongs_to)
    end
  end
end
