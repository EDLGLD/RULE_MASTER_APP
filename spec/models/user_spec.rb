require 'rails_helper'

describe User do
  let(:username) { 'テスト太郎' }
  let(:teamname) { 'テスト太郎' }
  let(:email) { 'test@example.com' }
  let(:password) { '12345678' }
  let(:user) { User.new(username:, email:, password:, password_confirmation: password) }

  describe '.first' do
    before do
      create(:user, username:, email:)
    end

    subject { described_class.first }

    it '事前に作成した通りのUserを返す' do
      expect(subject.username).to eq('テスト太郎')
      expect(subject.email).to eq('test@example.com')
    end
  end

  describe 'validation' do
    describe 'username属性' do
      describe '文字数制限の検証' do
        context 'usernameが20文字以下の場合' do
          let(:username) { 'あいうえおかきくけこさしすせそたちつてと' } # 20文字

          it 'User オブジェクトは有効である' do
            expect(user.valid?).to be(true)
          end
        end

        context 'usernameが20文字を超える場合' do
          let(:username) { 'あいうえおかきくけこさしすせそたちつてとな' } # 21文字

          it 'User オブジェクトは無効である' do
            user.valid?

            expect(user.valid?).to be(false)
            expect(user.errors[:username]).to include('is too long (maximum is 20 characters)')
          end
        end
      end
    end
  end
end
