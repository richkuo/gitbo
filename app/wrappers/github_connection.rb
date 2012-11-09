class GithubConnection

  attr_accessor :repo, :info, :issue_no

  def initialize(owner, repo, issue_no = nil)
    @repo = "#{owner}/#{repo}"
    @info = Octokit.repo(@repo)
    @issue_no = issue_no
  end

  def url
    self.info.html_url
  end

  def name
    self.info.name
  end

  def owner_name
    self.info.owner.login
  end

  def open_issues
    self.info.open_issues
  end

  def watchers
    self.info.watchers
  end

  def issue_title
    Octokit.issue(self.repo, self.issue_no).title
  end

  def issue_body
    Octokit.issue(self.repo, self.issue_no).body
  end

  def issue_number
    Octokit.issue(self.repo, self.issue_no).number
  end

end
