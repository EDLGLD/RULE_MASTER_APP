require 'rails_helper'

describe 'User', type: :system do
  before { driven_by :selenium_chrome_headless }

  # ユーザー情報入力用の変数
  let(:email) { 'test@example.com' }
  let(:username) { 'テスト太郎' }
  let(:password) { 'password' }
  let(:password_confirmation) { password }
  
  # チームネームを作成しておく
  let!(:team_name) { TeamName.create(name: 'Team A') }

  describe 'ユーザー登録機能の検証' do
    before { visit '/users/sign_up' }

    # ユーザー登録を行う一連の操作を subject にまとめる
    subject do
      select team_name.name, from: 'user_team_name_id'
      fill_in 'user_username', with: username
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password_confirmation
      click_button 'ユーザー登録'
    end

    context '正常系' do
      it 'ユーザーを作成できる' do
        expect { subject }.to change(User, :count).by(1) # Userが1つ増える
        expect(current_path).to eq('/') # ユーザー登録後はトップページにリダイレクト
      end
    end

    context '異常系' do
      context 'usernameが空の場合' do
        let(:username) { '' }
        it 'ユーザーを作成せず、エラーメッセージを表示する' do
          expect { subject }.not_to change(User, :count) # Userが増えない
          expect(page).to have_content("username can't be blank") # エラーメッセージのチェック
        end
      end

      context 'usernameが20文字を超える場合' do
        let(:username) { 'あ' * 21 }
        it 'ユーザーを作成せず、エラーメッセージを表示する' do
          expect { subject }.not_to change(User, :count)
          expect(page).to have_content('username is too long (maximum is 20 characters)')
        end
      end

      context 'emailが空の場合' do
        let(:email) { '' }
        it 'ユーザーを作成せず、エラーメッセージを表示する' do
          expect { subject }.not_to change(User, :count)
          expect(page).to have_content("Email can't be blank")
        end
      end

      context 'passwordが空の場合' do
        let(:password) { '' }
        it 'ユーザーを作成せず、エラーメッセージを表示する' do
          expect { subject }.not_to change(User, :count)
          expect(page).to have_content("Password can't be blank")
        end
      end

      context 'passwordが6文字未満の場合' do
        let(:password) { 'a' * 5 }
        it 'ユーザーを作成せず、エラーメッセージを表示する' do
          expect { subject }.not_to change(User, :count)
          expect(page).to have_content('Password is too short (minimum is 6 characters)')
        end
      end

      context 'passwordが128文字を超える場合' do
        let(:password) { 'a' * 129 }
        it 'ユーザーを作成せず、エラーメッセージを表示する' do
          expect { subject }.not_to change(User, :count)
          expect(page).to have_content('Password is too long (maximum is 128 characters)')
        end
      end

      context 'passwordとpassword_confirmationが一致しない場合' do
        let(:password_confirmation) { "#{password}hoge" } # passwordに"hoge"を足した文字列にする
        it 'ユーザーを作成せず、エラーメッセージを表示する' do
          expect { subject }.not_to change(User, :count)
          expect(page).to have_content("Password confirmation doesn't match Password")
        end
      end
    end
  end
end
