require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  describe "バリデーションのテスト" do
    it "有効なユーザーが作成できる" do
      expect(user).to be_valid
    end

    it "名前が必須である" do
      user.name = nil
      expect(user).to_not be_valid
    end

    it "メールアドレスが必須である" do
      user.email = nil
      expect(user).to_not be_valid
    end

    it "メールアドレスが一意である" do
      duplicate_user = user.dup
      user.save
      expect(duplicate_user).to_not be_valid
    end
  end

  describe "アソシエーションのテスト" do
    it "ユーザーがイベントを持つ" do
      expect(User.reflect_on_association(:events).macro).to eq(:has_many)
    end

    it "ユーザーがお気に入りイベントを持つ" do
      expect(User.reflect_on_association(:favorite_events).macro).to eq(:has_many)
    end

    it "ユーザーが参加イベントを持つ" do
      expect(User.reflect_on_association(:join_events).macro).to eq(:has_many)
    end

    it "ユーザーがレビューを1つだけ持つ" do
      expect(User.reflect_on_association(:review).macro).to eq(:has_one)
    end
  end

  describe "インスタンスメソッドのテスト" do
    describe "#authenticated?" do
      it "トークンが一致する場合trueを返す" do
        user.activation_token = User.new_token
        user.activation_digest = User.digest(user.activation_token)
        expect(user.authenticated?(:activation, user.activation_token)).to be_truthy
      end

      it "トークンが一致しない場合falseを返す" do
        user.activation_token = User.new_token
        user.activation_digest = User.digest(user.activation_token)
        expect(user.authenticated?(:activation, "invalid_token")).to be_falsey
      end
    end

    describe "#activate" do
      it "ユーザーを有効化する" do
        user.activate
        expect(user.activated).to be_truthy
        expect(user.activated_at).to_not be_nil
      end
    end
  end

  describe "プライベートメソッドのテスト" do
    describe "#downcase_email" do
      it "メールアドレスを小文字に変換する" do
        user.email = "EXAMPLE@EMAIL.COM"
        user.save
        expect(user.reload.email).to eq("example@email.com")
      end
    end
  end
end
