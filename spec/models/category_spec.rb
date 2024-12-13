require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { FactoryBot.build(:category) }

  describe "バリデーションのテスト" do
    it "有効なカテゴリーが作成できる" do
      expect(category).to be_valid
    end

    it "カテゴリー名が必須である" do
      category.name = nil
      expect(category).to_not be_valid
    end

    it "カテゴリー名が一意である" do
      duplicate_category = category.dup
      category.save
      expect(duplicate_category).to_not be_valid
    end
  end

  describe "アソシエーションのテスト" do
    it "カテゴリーが複数のイベントを持つ" do
      expect(Category.reflect_on_association(:events).macro).to eq(:has_many)
    end
  end
end
