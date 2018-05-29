require 'rails_helper'

describe Task, type: :model do
  DatabaseRewinder.clean_all

  describe 'validation' do
    user = FactoryGirl.create(:user)
    let(:task) { FactoryGirl.create(:task, user_id: user.id) }
    subject { task }

    describe 'valid' do
      it{ is_expected.to be_valid }
    end

    it "喜び(タスク)を入力しなかった場合" do
      task = FactoryGirl.build(:task, caption: "", user_id: user.id)
      task.valid?
      expect(task.errors[:caption]).to include("ない")
    end

    it "喜び（タスク）が１００文字を超えていた場合" do
      task = FactoryGirl.build(:task, caption: "はろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテスト", user_id: user.id)
      task.valid?     # データとして正しいか　　これをやらないとエラーにならない
      expect(task.errors[:caption]).to include("が100文字を超えている")
    end

  end
end
