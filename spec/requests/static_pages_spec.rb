require 'spec_helper'

describe "Static pages" do

  subject { page }
  describe "Home page" do
  	before { visit root_path }
    it { should have_content('Mytwitter')}
    it { should have_title(full_title(''))}
    it { should_not have_title('| Home')}
  end

  describe "Help page" do
    before { visit help_path }
    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }
    it { should have_content('About') }
    it { should have_title(full_title('About Us')) }
  end

   #Аналогичный вариант
   let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  describe "Contact page" do
	before { visit contact_path }
    it "should have the content 'Contact'" do
      expect(page).to have_content('Contact')
    end

    it "should have the title 'Contact'" do
      expect(page).to have_title("#{base_title} | Contact")
    end
  end

end
