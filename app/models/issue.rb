class Issue < ActiveRecord::Base
  attr_accessible :body, :git_number, :title, :repo, :comment_count

  belongs_to :repo

  validates :git_number, :uniqueness => { :scope => :repo_id } 

  def self.create_from_github(owner, repo, issue)
    connection = GithubConnection.new(owner, repo, issue)

    Issue.new(:git_number => connection.issue_number,
                  :body => connection.issue_body,
                  :title => connection.issue_title,
                  :comment_count => connection.issue_comments
                  ).tap do |i|
      i.repo = Repo.find_or_create_by_name("#{repo}")
      i.save
    end
  end

end
