FactoryGirl.define do
  factory :user do
    provider "github"
    uid  "755826"
    name "Adam Jonas"
    nickname "ajonas04"
    email "francestown81@gmail.com"
    image "https://secure.gravatar.com/avatar/080d50aff18e2675b626e5107768af94?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"
    token "0eea25e3f3730a3d1e8fc04c39fe820b39a12624"
  end

  factory :repo do
    name "spree"
    owner_name "spree"
    watchers 3432
    open_issues 49
    slug "spree"
    git_updated_at Date.new(2012, 11, 28)
  end

  factory :issue do
    title "this is a test title"
    body "this is the body of the issue"
    repo_id 1
    comment_count 0
    owner_name "spree"
    git_updated_at Date.new(2012, 11, 28)
    owner_image "https://secure.gravatar.com/avatar/1f0b221851379759360d7130dabdfa53?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"
    owner_endorsement 1
    vote_count 2
    avg_difficulty 3.5
    repo_name 'spree'
    repo_owner 'spree'
    bounty_total '20'
  end

end
