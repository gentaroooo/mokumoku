require 'rails_helper'
  
RSpec.describe 'Users', type: :system do
  let(:existed_user) { create(:user) }

  describe 'ユーザー新規作成' do
    context '正常系' do
      it 'ユーザーの新規作成ができる' do
        visit new_user_path
        fill_in 'Name', with: 'test01'
        fill_in 'Email', with: 'test01@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        expect { click_button '登録' }.to change { User.count }.by(1)
        expect(current_path).to eq events_path
      end
    end
  end

  describe 'ユーザー一覧表示' do
    let!(:me) { create(:user) }
    let!(:others) { create(:user) }
    before { login_as(me) }
    
    context '正常系' do
      it 'ログインしたユーザーがユーザー一覧に表示される' do
        visit users_path(me)
        expect(page).to have_content me.name
      end
      it 'ログインしていないユーザーがユーザー一覧に表示される' do
        visit users_path(me)
        expect(page).to have_content others.name
      end
      it 'ユーザー一覧に自己紹介が表示される' do
        visit users_path(me)
        expect(page).to have_content me.introduction
        expect(page).to have_content others.introduction
      end
      it 'ユーザー詳細画面が表示される' do
        visit users_path(me)
        click_link me.name
        expect(page).to have_content me.introduction
        expect(page).to_not have_content others.introduction
      end
    end
  end
end
