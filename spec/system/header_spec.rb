require 'rails_helper'

RSpec.describe "header", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "screen details" do
    let!(:user){create(:user)}
    context "when user is logged in" do
      before do
        register_category
        login user
        visit root_path
      end
      
      it "displays header logo" do
        expect(page).to have_content('Sharevel')
      end
      
      it "displays link for new_post_path" do
        expect(page).to have_link "旅をシェア", href: new_post_path 
      end
      
      it "displays link for new_question_path" do
        expect(page).to have_link "旅人に質問", href: new_question_path 
      end
      
      it "displays link for new_question_path" do
        expect(page).to have_link "投稿を一覧", href: root_path
      end
      
      it "displays link for user_path" do
        expect(page).to have_link "プロフィール", href: user_path(user)
      end
      
      it "displays link for logout_path" do
        expect(page).to have_link "ログアウト", href: logout_path
      end
    end
  end

  describe "screen oparations" do
    let!(:user){create(:user)}
    before do
      register_category
      login user
      visit root_path
    end
    context "when user is logged in" do
      context "when logo is clicked" do
        it "redirects to root_path" do
          click_on "sharevel-header"
          expect(current_path).to eq root_path
        end
      end
      
      context "when 投稿を一覧 is clicked" do
        it "redirects to root_path" do
          click_on "投稿を一覧", match: :first
          expect(current_path).to eq root_path
        end
      end
      
      context "when 旅をシェア is clicked" do
        it "redirects to new_post_path" do
          click_on "旅をシェア"
          expect(current_path).to eq new_post_path
        end
      end
      
      context "when 旅人に質問 is clicked" do
        it "redirects to new_question_path" do
          click_on "旅人に質問"
          expect(current_path).to eq new_question_path
        end
      end
      
      context "when プロフィール is clicked" do
        it "redirects to user_path" do
          click_on "プロフィール"
          expect(current_path).to eq user_path(user)
        end
      end
      
      context "when ログアウト is clicked" do
        it "redirects to top_path" do
          click_on "ログアウト"
          expect(current_path).to eq top_path
        end
      end
    end
  end
end