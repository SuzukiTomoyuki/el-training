require 'rails_helper'

feature 'Session', type: :feature do

  describe 'user' do

    describe 'login' do
      before do
        FactoryGirl.create(:user)
        visit login_path
      end

      it 'ログインしましたとトーストがでる', js:true do
        fill_in 'メールアドレス', with: 'hogehoge@gmail.com'
        fill_in 'パスワード', with: '12345'
        click_on 'ログイン'
        expect(page).to have_content 'ログインしました'
      end
    end
  end
end