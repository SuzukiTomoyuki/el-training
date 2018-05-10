require 'rails_helper'

feature 'TasksList', type: :feature do
  # コンピテンシーではアクションで切ってる
  describe "#index" do
    let(:default_datetime) { Date.new(2020, 1, 1)}

    before do
      allow(Date).to receive(:today).and_return(:default_datetime)
      1.upto 5 do |row|
        Task.create(
                caption: "caption#{row}",
                priority_id: Task.new(priority_id: :high).priority_id,
                status_id: Task.new(status_id: :to_do).status_id,
                created_at: default_datetime + row.hour,
                deadline: default_datetime + row.day
        )
        visit tasks_list_index_path
      end
    end

    # subject { page }

    it "タスクが５つ表示される" do
      expect(all('tbody tr').size).to eq 5
    end

    describe 'sort' do

      describe '作成日時でソート' do

        context '作成日をクリック(昇順)' do
          before do
            click_on('作成日')
          end

          it '昇順ソート' do
            expect(page.all("tbody tr")[0].all("td")[4].text).to eq "2020年01月01日 01時00分"
            expect(page.all("tbody tr")[1].all("td")[4].text).to eq "2020年01月01日 02時00分"
            expect(page.all("tbody tr")[2].all("td")[4].text).to eq "2020年01月01日 03時00分"
          end
        end

        context '作成日をクリック(降順)' do
          before do
            click_on('作成日')
            click_on('作成日')
            click_on('作成日')
            click_on('作成日')
          end

          it '降順ソート' do
            expect(page.all("tbody tr")[0].all("td")[4].text).to eq "2020年01月01日 05時00分"
            expect(page.all("tbody tr")[1].all("td")[4].text).to eq "2020年01月01日 04時00分"
            expect(page.all("tbody tr")[2].all("td")[4].text).to eq "2020年01月01日 03時00分"
          end
        end

      end

      describe '締め切りでソート' do

        context '締め切りをクリック(昇順)' do
          before do
            click_on('締め切り')
          end

          it '昇順ソート' do
            expect(page.all("tbody tr")[0].all("td")[3].text).to eq "2020年01月02日 00時00分"
            expect(page.all("tbody tr")[1].all("td")[3].text).to eq "2020年01月03日 00時00分"
            expect(page.all("tbody tr")[2].all("td")[3].text).to eq "2020年01月04日 00時00分"
          end
        end

        context '締め切りをクリック(降順)' do
          before do
            click_on('締め切り')
            click_on('締め切り')
          end

          it '降順ソート' do
            expect(page.all("tbody tr")[0].all("td")[3].text).to eq "2020年01月06日 00時00分"
            expect(page.all("tbody tr")[1].all("td")[3].text).to eq "2020年01月05日 00時00分"
            expect(page.all("tbody tr")[2].all("td")[3].text).to eq "2020年01月04日 00時00分"
          end
        end
      end

    end

  end

  describe '優先度でソート(index)' do

    before do
      visit tasks_list_index_path
      0.upto(2) do |i|
        FactoryGirl.create(:task, priority_id: Task.priority_ids.keys[i])
      end
    end

    context '優先度をクリック(昇順)' do
      before do
        click_on('優先度')
      end

      it '昇順ソート' do
        expect(page.all("tbody tr")[0].all("td")[1].text).to match "高"
        expect(page.all("tbody tr")[1].all("td")[1].text).to match "中"
        expect(page.all("tbody tr")[2].all("td")[1].text).to match "低"
      end
    end

    context '優先度をクリック(降順)' do
      before do
        click_on('優先度')
        click_on('優先度')
      end

      it '降順ソート' do
        expect(page.all("tbody tr")[0].all("td")[1].text).to match "低"
        expect(page.all("tbody tr")[1].all("td")[1].text).to match "中"
        expect(page.all("tbody tr")[2].all("td")[1].text).to match "高"
      end
    end
  end

  describe '状態でソート(index)' do

    before do
      visit tasks_list_index_path
      0.upto(2) do |i|
        FactoryGirl.create(:task, status_id: Task.status_ids.keys[i])
      end
    end

    context '状態をクリック(昇順)' do
      before do
        click_on('状態')
        click_on('状態')
      end

      it '昇順ソート' do
        expect(page.all("tbody tr")[0].all("td")[2].text).to match "完了"
        expect(page.all("tbody tr")[1].all("td")[2].text).to match "着手中"
        expect(page.all("tbody tr")[2].all("td")[2].text).to match "着手待ち"
      end
    end

    context '状態をクリック(降順)' do
      before do
        click_on('状態')
        click_on('状態')
        click_on('状態')
      end

      it '降順ソート' do
        expect(page.all("tbody tr")[0].all("td")[2].text).to match "着手待ち"
        expect(page.all("tbody tr")[1].all("td")[2].text).to match "着手中"
        expect(page.all("tbody tr")[2].all("td")[2].text).to match "完了"
      end
    end
  end


  describe "#new" do
    it "新しいタスクを追加する" do
      expect{
        visit new_tasks_list_path
        fill_in "task[caption]", with: "fxxxen task"
        select "高", from: "task[priority_id]"
        select "着手待ち", from: "task[status_id]"
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
      @task = FactoryGirl.create(:task, caption:"俺はテストを行う!", deadline: Date.today)
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