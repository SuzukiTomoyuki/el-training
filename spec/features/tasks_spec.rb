require 'rails_helper'

feature 'Tasks', type: :feature do
  # コンピテンシーではアクションで切ってる
  describe "#index" do
    let(:default_datetime) { Date.new(2020, 1, 1)}

    before do
      allow(Date).to receive(:today).and_return(:default_datetime)
      1.upto 5 do |row|
        Task.create(
                caption: "caption#{row}",
                priority: :high,
                status: :doing,
                created_at: default_datetime + row.hour,
                deadline: default_datetime + row.day
        )
        visit tasks_path
      end
    end

    # subject { page }

    it "タスクが５つ表示される" do
      expect(all('tbody tr').size).to eq 5
    end

    describe 'sort' do

      # describe '作成日時でソート' do
      #
      #   context '作成日をクリック(昇順)' do
      #     before do
      #       click_on('作成日')
      #     end
      #
      #     it '昇順ソート' do
      #       expect(page.all("tbody tr")[0].all("td")[4].text).to eq "2020年01月01日 01時00分"
      #       expect(page.all("tbody tr")[1].all("td")[4].text).to eq "2020年01月01日 02時00分"
      #       expect(page.all("tbody tr")[2].all("td")[4].text).to eq "2020年01月01日 03時00分"
      #     end
      #   end
      #
      #   context '作成日をクリック(降順)' do
      #     before do
      #       click_on('作成日')
      #       click_on('作成日')
      #     end
      #
      #     it '降順ソート' do
      #       expect(page.all("tbody tr")[0].all("td")[4].text).to eq "2020年01月01日 05時00分"
      #       expect(page.all("tbody tr")[1].all("td")[4].text).to eq "2020年01月01日 04時00分"
      #       expect(page.all("tbody tr")[2].all("td")[4].text).to eq "2020年01月01日 03時00分"
      #     end
      #   end
      #
      # end

      describe '締め切りでソート' do

        context '締め切りをクリック(昇順)' do
          before do
            click_on('締め切り')
          end

          it '昇順ソート' do
            # expect(click_on('締め切り'))
            expect(page.all("tbody tr")[0].all("td")[3].text).to eq "2020年01月02日"
            expect(page.all("tbody tr")[1].all("td")[3].text).to eq "2020年01月03日"
            expect(page.all("tbody tr")[2].all("td")[3].text).to eq "2020年01月04日"
          end
        end

        context '締め切りをクリック(降順)' do
          before do
            click_on('締め切り')
            click_on('締め切り')
          end

          it '降順ソート' do
            expect(page.all("tbody tr")[0].all("td")[3].text).to eq "2020年01月06日"
            expect(page.all("tbody tr")[1].all("td")[3].text).to eq "2020年01月05日"
            expect(page.all("tbody tr")[2].all("td")[3].text).to eq "2020年01月04日"
          end
        end
      end

    end

  end

  describe '優先度でソート(index)' do

    before do
      visit tasks_path
      0.upto(2) do |i|
        FactoryGirl.create(:task, priority: Task.priorities.keys[i])
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
      visit tasks_path
      0.upto(2) do |i|
        FactoryGirl.create(:task, status: Task.statuses.keys[i])
      end
    end

    context '状態をクリック(昇順)' do
      before do
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
      end

      it '降順ソート' do
        expect(page.all("tbody tr")[0].all("td")[2].text).to match "着手待ち"
        expect(page.all("tbody tr")[1].all("td")[2].text).to match "着手中"
        expect(page.all("tbody tr")[2].all("td")[2].text).to match "完了"
      end
    end
  end

  describe 'serch(index)' do

    before do
      visit tasks_path
      0.upto(2) do |i|
        FactoryGirl.create(:task, caption: "#{i + 1}番目の喜び" ,status: Task.statuses.keys[i])
      end
    end

    describe 'タスク名（喜び）で検索' do
      before do
        fill_in "caption", with: "1"
        click_on('検索')
      end

      it '"1番目の喜び"が出力される' do
        expect(page.all("tbody tr")[0].all("td")[0].text).to match "1番目の喜び"
      end
    end

    describe '状態で検索' do
      before do
        select "着手中", from: "status"
        click_on('検索')
      end

      it '"2番目の喜び"が出力される' do
        expect(page.all("tbody tr")[0].all("td")[0].text).to match "2番目の喜び"
      end
    end

  end
end




feature 'Tasks_js', type: :feature, js:true do

  describe "#new" do
    before do
      visit tasks_path
      find("#new_button").click
    end

    it "新しいタスクを追加する" do
      expect{
        # visit new_task_path

        fill_in "task[caption]", with: "fxxxen task"
        select "高", from: "task[priority]"
        select "着手待ち", from: "task[status]"
        fill_in "task[label]", with: nil
        find("#submit_button").click
        expect(page).to have_content "新しい喜び"
      }.to change(Task, :count).by(1)
    end
  end

  describe "#delete" do
    before do
      task = FactoryGirl.create(:task, deadline: Date.today)
      visit tasks_path(task)
    end
    it "indexに表示されているタスクを削除する" do
      expect{
        # page.all("tbody tr")[0].find_by_id("#delete_button").click
        find('.delete-task-btn').click
        page.save_screenshot '~/Desktop/sample.png'
        click_on '破壊'
      }.to change(Task, :count).by(-1)
    end
  end

  describe "#edit" do
    before do
      @task = FactoryGirl.create(:task, caption:"俺はテストを行う!", deadline: Date.today)
      visit tasks_path(@task)
      # page.all("tbody tr")[0].find_by_id("edit_button").click
    end
    let(:message) {"俺はテストを行わない!"}
    let(:task_row) { Task.find(@task.id)}
    it "indexに表示されているタスクを編集する" do
      find('#edit_button').click
      fill_in "task[caption]", with: message
      page.save_screenshot '~/Desktop/sample.png'
      expect(find("#submit_button").click)
      expect(page).to have_content "より強い喜び"
      # sleep(0.5)
      expect(
        task_row.caption
      ).to eq(message)
    end
  end
end