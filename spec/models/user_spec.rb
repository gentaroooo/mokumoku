# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:created_user) { create(:user) }

  describe 'スコープ' do
    describe 'allowing_created_event_notification' do
      let!(:allowed_user) do
        user = create(:user)
        user.notification_timings << NotificationTiming.find_by!(timing: :created_event)
        user
      end
      let!(:not_allowed_user) { create(:user) }

      it '対象が正しいこと' do
        expect(User.allowing_created_event_notification).to include(allowed_user)
        expect(User.allowing_created_event_notification).not_to include(not_allowed_user)
      end
    end

    describe 'allowing_commented_to_event_notification' do
      let!(:allowed_user) do
        user = create(:user)
        user.notification_timings << NotificationTiming.find_by!(timing: :commented_to_event)
        user
      end
      let!(:not_allowed_user) { create(:user) }

      it '対象が正しいこと' do
        expect(User.allowing_commented_to_event_notification).to include(allowed_user)
        expect(User.allowing_commented_to_event_notification).not_to include(not_allowed_user)
      end
    end

    describe 'allowing_attended_to_event_notification' do
      let!(:allowed_user) do
        user = create(:user)
        user.notification_timings << NotificationTiming.find_by!(timing: :attended_to_event)
        user
      end
      let!(:not_allowed_user) { create(:user) }

      it '対象が正しいこと' do
        expect(User.allowing_attended_to_event_notification).to include(allowed_user)
        expect(User.allowing_attended_to_event_notification).not_to include(not_allowed_user)
      end
    end

    describe 'allowing_liked_event_notification' do
      let!(:allowed_user) do
        user = create(:user)
        user.notification_timings << NotificationTiming.find_by!(timing: :liked_event)
        user
      end
      let!(:not_allowed_user) { create(:user) }

      it '対象が正しいこと' do
        expect(User.allowing_liked_event_notification).to include(allowed_user)
        expect(User.allowing_liked_event_notification).not_to include(not_allowed_user)
      end
    end
  end

  describe 'メソッド' do
    describe 'attend' do
      let!(:user) { create(:user) }
      let!(:event) { create(:event) }
      it 'イベントへの参加処理が行われること' do
        expect do
          user.attend(event)
        end.to change { EventAttendance.count }.by(1)
      end
    end

    describe 'cancel_attend' do
      let!(:user) { create(:user) }
      let!(:event) { create(:event) }
      before do
        user.attend(event)
      end
      it 'イベントへのキャンセル処理が行われること' do
        expect do
          user.cancel_attend(event)
        end.to change { EventAttendance.count }.by(-1)
      end
    end
  end

  describe 'バリデーション確認' do
    it '有効であること' do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it '重複したメールアドレスの場合、無効' do
      user = build(:user, email: created_user.email)
      expect(user).to be_invalid
    end

    it 'パスワードがない場合、無効' do
      user = build(:user, password: nil)
      expect(user).to be_invalid
    end

    it 'パスワードが3文字より小さい場合、無効' do
      user = build(:user, password: 'a' * 3)
      expect(user).to be_invalid
    end

    it 'パスワードとパスワード確認が一致していない場合、無効' do
      user = build(:user, password_confirmation: 'abcdefgh')
      expect(user).to be_invalid
    end

    it '自己紹介が1000文字より大きい場合、無効' do
      user = build(:user, introduction: 'a' * 1001)
      expect(user).to be_invalid
    end
  end
end
