# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Relationships', type: :system do
  describe 'フォロー機能' do
    let(:me) { create(:user) }
    let(:my_following_user) { create(:user) }
    let(:others) { create(:user) }
    before do
      login_as(me)
      visit user_path(my_following_user)
      click_button 'フォロー'
    end

    context '正常系' do
      it 'フォローできる' do
        visit user_path(others)
        click_button 'フォロー'
        expect(page).to have_button('フォロー解除')
      end

      it 'フォロー解除できる' do
        visit user_path(my_following_user)
        click_button 'フォロー解除'
        expect(page).to have_button('フォロー')
      end

      it '自分のユーザー詳細画面にフォローボタンが表示されない' do
        visit user_path(me)
        expect(page).not_to have_button('フォロー')
      end

      it '他人のユーザー詳細画面にフォローボタンが表示される' do
        visit user_path(others)
        expect(page).to have_button('フォロー')
      end

      it 'フォローしているユーザが表示される' do
        visit following_user_path(me)
        expect(page).to have_content my_following_user.name
      end

      it 'フォローされているユーザが表示される' do
        visit follower_user_path(my_following_user)
        expect(page).to have_content me.name
      end
    end
  end
end
