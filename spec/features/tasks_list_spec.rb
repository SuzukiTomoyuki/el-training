require 'rails_helper'

feature 'TasksList', type: :feature do
  # コンピテンシーではアクションで切ってる
  describe "#index" do
    let(:default_datetime) { Date.new(2020, 1, 1)}

    before do
      allow(Date).to receive(:today).and_return(:default_datetime)
      create_at = Time.parse('2018-05-01 00:00:00')
      1.upto 5 do |row|
        Task.create(
                caption: "caption#{row}",
                priority: "S",
                state: "着手待ち",
                created_at: default_datetime + row.hour,
                deadline: default_datetime + row.day
        )
      end
      visit tasks_list_index_path
    end

    # subject { page }

    it "タスクが５つ表示される" do
      expect(all('tbody tr').size).to eq 5
    end

    describe 'sort' do

    end
  end

  describe "#new" do
    it "新しいタスクを追加する" do
      expect{
        visit new_tasks_list_path
        fill_in "task[caption]", with: "fxxxen task"
        select "A", from: "task[priority]"
        select "着手待ち", from: "task[state]"
        # select I18n.l(Date.today, format: '%B'), from: "task[deadline]"
        fill_in "task[label]", with: nil
        click_button "喜びを追加"
      }.to change(Task, :count).by(1)
    end
  end

  describe "#delete" do
    before do
      1.upto(10) do |row|
        FactoryGirl.create(:task, deadline: Date.today + row.hour)
      end
    end
    it "indexに表示されているタスクを削除する" do
      visit tasks_list_index_path
      expect{
        page.all("tbody tr")[0].find_by_id("delete_button").click
        # click_on('削除')
      }.to change(Task, :count).by(-1)
    end
  end

  describe "#edit" do
    before do
      @task = FactoryGirl.create(:task,caption:"俺はテストを行う!", deadline: Date.today)
      visit tasks_list_index_path
      page.all("tbody tr")[0].find_by_id("edit_button").click
    end
    let(:message) {"俺はテストを行わない!"}
    let(:task_row) { Task.find(@task.id)}
    it "indexに表示されているタスクを編集する" do
      fill_in "task[caption]", with: message
      click_button "喜びを更新"
      expect(
        task_row.caption
      ).to eq(message)
    end
  end

end