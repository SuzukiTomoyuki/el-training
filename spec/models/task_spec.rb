require 'rails_helper'

describe Task, type: :model do

  describe 'validation' do
    let(:task) { FactoryGirl.create(:task) }
    subject { task }

    describe 'valid' do
      it{ is_expected.to be_valid }
    end

    it "喜び(タスク)を入力しなかった場合" do
      task = FactoryGirl.build(:task, caption: "")
      task.valid?
      expect(task.errors[:caption]).to include("が無い。何も無い。")
    end

    it "喜び（タスク）が１００文字を超えていた場合" do
      task = FactoryGirl.build(:task, caption: "はろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテストはろーテスト")
      task.valid?
      expect(task.errors[:caption]).to include("が100文字を超えて")
    end

  end
end