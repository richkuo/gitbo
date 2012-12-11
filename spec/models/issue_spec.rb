require 'spec_helper'

describe Issue do

  context "it should import info from Github and create Issue" do

    context ".create_from_github" do

      xit "should persist an issue from Github" do
        issue = Issue.create_from_github("intridea", "omniauth", 645)

        Issue.find_by_git_number(645).should be_true
        Issue.find_by_title("TypeError on Ruby 1.8.7 - 0.3.0-stable branch").should be_true
        Issue.find_by_git_number(645).body.should include("OmniAuth::Strategies::SAML::AuthRequest")

      end



    end
  end
end
