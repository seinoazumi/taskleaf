require 'rails_helper'

describe "タスク管理機能", type: :system do
  describe "一覧表示機能" do
    let(:user_a) { FactoryBot.create(:user, name: "userA", email: "a@example.com") }
    let(:user_b) { FactoryBot.create(:user, name: "userB", email: "b@example.com") }
    let!(:task_a) { FactoryBot.create(:task, name: "最初のタスク", user: user_a) }

    before do  
      visit login_path
      fill_in "session[email]", with: login_user.email
      fill_in "session[password]", with: login_user.password
      click_button 'ログインする'
    end

    shared_examples_for "ユーザーAが作成したタスクが表示される" do
      it { expect(page).to have_content "最初のタスク" }
    end

    describe "一覧表示機能" do
      context "ユーザーAとしてログインしている時" do
        let(:login_user) { user_a }

        it_behaves_like "ユーザーAが作成したタスクが表示される"
      end

      context "ユーザーBとしてログインしている時" do
        let(:login_user) { user_b }

        it "ユーザーAの作ったタスクは表示されない" do 
          expect(page).to have_no_content("最初のタスク")
        end
      end
    end

    describe "詳細表示機能" do
      context "ユーザーAがログインしている時" do
        let(:login_user) { user_a }

        before do
          visit task_path(task_a)
        end

        it_behaves_like "ユーザーAが作成したタスクが表示される"
      end
    end

    describe "新規作成機能" do
      let(:login_user) { user_a }

      before do
        visit new_task_path
        fill_in  'task[name]', with: task_name
        click_button '確認'
      end

      context '新規作成画面で名前を入力した時' do
        let(:task_name) { '新規作成のテストを書く' }

        it '確認画面に遷移する' do
          expect(current_path).to eq confirm_new_task_path
        end

        it '入力した名称のタスクが確認画面に表示されている' do
          expect(page).to have_content('新規作成のテストを書く')
        end
      end

      context '新規作成画面で名前を入力しなかった時' do
        let(:task_name) { '' }

        it '「名前のないタスク」という文字が挿入されている' do
          expect(page).to have_content '名前のないタスク'
        end
      end

    end
  end
end
