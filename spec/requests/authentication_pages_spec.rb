require 'spec_helper'

describe "Authentication" do
  before { visit signin_path }
  subject{page}

  it { should have_content("Sign in")}
  it { should have_title("Sign in")}


  describe "sign in" do
    before { visit signin_path }


    describe "with invalid information" do
      before { click_button "Sign in" }
      it { should have_title("Sign in") }
      it { should have_selector('div.alert.alert-error',text:"Invalid")}

      describe "after visiting another page" do
        before { click_link "Home"}
        it { should_not have_selector('div.alert.alert-error',text:"Invalid")}
      end

    end


    describe "before sign in should not see these links in header" do
      it { should_not have_link('Profile')}
      it { should_not have_link('Setting')}
      it { should_not have_link('Sign out')}
      it { should have_link('Sign in')}
      it { should_not have_link('Users')}
    end


    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user)}
      before { sign_in user }

      it { should have_title(user.name) }
      it { should have_link('Profile',   href: user_path(user))}
      it { should have_link('Setting', href:edit_user_path(user))}
      it { should have_link('Sign out',  href: signout_path)}
      it { should_not have_link('Sign in', href: signin_path)}
      it { should have_link('Users', href: users_path)}
    end
  end


  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end


        describe "after signing in" do
          it "should render the desired protected page" do
            expect(page).to have_title("Edit user")
          end
        end
      end
    end


    describe "for non-signed-in users" do
      let(:user) {FactoryGirl.create(:user)}

      describe "in the Users controller" do
        before { visit edit_user_path(user) }
        it { should have_title("Sign in") }
      end

      describe "submitting to the update action" do
        before { patch user_path(user) }
        specify { expect(response).to redirect_to(signin_path)}
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email:"wrong@example.com")}

      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to the User#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_url) }
      end


      describe "visiting the user index" do
        before { visit users_path }
        it { should have_title('Sign in') }
      end
    end
  end
end
