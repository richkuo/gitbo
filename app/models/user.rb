class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :image

  has_many :user_votes
  has_many :bounties

  def self.create_with_omniauth(auth)
  create! do |user|
    user.provider = auth["provider"]
    user.uid = auth["uid"]
    user.name = auth["info"]["name"]
    user.nickname = auth["info"]["nickname"]
    user.email = auth["info"]["email"]
    user.image = auth["info"]["image"]
    end
  end

  def session_token
    session[:token]
  end
  
  def load_cache_info(client, user)
    Rails.cache.fetch(user.nickname.to_sym, expires_in: 24.hours) do
      { :repos => client.repositories(user.nickname).collect {|repo| repo.name },
        :following => client.following(user.nickname).collect {|user| user.login },
        :starred => client.starred(user.nickname).collect {|repo| "#{repo.owner.login}/#{repo.name}" }  }
    end
  end

end
