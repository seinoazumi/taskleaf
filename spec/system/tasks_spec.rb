require 'rails_helper'

describe "タスク管理機能", type: :system do
  describe "一覧表示機能" do
    let!(:user_a) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, name: "最初のタスク", user: user_a) }

    context "ユーザーAとしてログインしている時" do
      it "作成したタスクが表示される" do
        visit login_path
        fill_in "session[email]", with: user_a.email
        fill_in "session[password]", with: user_a.password
        click_button 'ログインする'
        expect(page).to have_content("最初のタスク")
      end
    end
  end
end
