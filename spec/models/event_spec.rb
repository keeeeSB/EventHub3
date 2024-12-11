require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category) }
  let(:event) { FactoryBot.build(:event, user: user, category: category) }

  describe "バリデーションのテスト" do
    it "有効なイベントを作成できる" do
      expect(event).to be_valid
    end

    it "タイトルが必須である" do
      event.title = nil
      expect(event).to_not be_valid
    end

    it "説明が必須である" do
      event.description = nil
      expect(event).to_not be_valid
    end

    it "開催日時が必須である" do
      event.start_time = nil
      expect(event).to_not be_valid
    end

    it "場所が必須である" do
      event.location = nil
      expect(event).to_not be_valid
    end
  end

  describe "アソシエーションのテスト" do
    it "ユーザーに属している" do
      expect(Event.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it "カテゴリーに属している" do
      expect(Event.reflect_on_association(:category).macro).to eq(:belongs_to)
    end

    it "複数の参加予定イベントを持つ" do
      expect(Event.reflect_on_association(:joins).macro).to eq(:has_many)
    end

    it "複数のお気に入りイベントを持つ" do
      expect(Event.reflect_on_association(:favorites).macro).to eq(:has_many)
    end

    it "複数のレビューを持つ" do
      expect(Event.reflect_on_association(:reviews).macro).to eq(:has_many)
    end
  end
end
