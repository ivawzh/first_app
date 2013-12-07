require 'spec_helper'

describe "MicropostPages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  it { should have_content(user.name)}
  it { should have_content(user.email)}

  describe "micropost creation" do
    before { visit root_path }
    it "should not create a micropost" do
      expect { click_button "Post" }.not_to change(Micropost, :count)
    end


    describe "error messages" do
      before { click_button "Post" }
      it { should have_content('Error') }
    end


    describe "with valid information" do
      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a microsoft" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end


    describe "delete micropost" do
      before { visit root_path }
      #let(:post) { FactoryGirl.create(:micropost, user: user, content: "This is whatever") }
      before do
        fill_in "micropost_content", with: "This is whatever"
        click_button "Post"
      end
      it { should have_content("Micropost created!")}
      it { should have_content("This is whatever") }
      describe "click on delete as a right user" do #,js=true do
        before do
          click_link "delete"
          #page.driver.browser.switch_to.alert.accept
        end
        it { should have_selector( "div.alert.alert-success",text:"You have deleted the microposts with content: This is whatever")}
      end

      describe "delete post as a wrong user" do
        let(:post) { FactoryGirl.create(:micropost, user: FacotryGirl.create(:user), content: "This won't be deleted by a wrong user")}
        it{ expect{ delete micropost_path(:post) }.not_to change(Micropost, :count)}
      end


      describe "delete link should not be shown for wrong user" do
        let(:another_user) { FactoryGirl.create(:user) }
        before do
          FactoryGirl.create(:micropost, user: another_user, content: "can't see delete on me")
          visit user_path(another_user)
        end
          it{ should_not have_link(:delete)}
      end
    end
  end














end
