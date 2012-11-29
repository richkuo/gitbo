class UsersController < ApplicationController
  # GET /users
  # GET /users.json

  helper_method :repo_owner

  def index
    @users = User.all
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @new_repo = Repo.new
    # @issues = Issue.all_open_issues
    # 1.times { @new_repo.issues.build}

    # TODO: Add a check below for whether the user is authenticated and
    # render :show_authenticated
    if current_user && current_user.nickname == params[:owner]
      @user = User.find_by_nickname(params[:owner])
      @repos = Repo.find_all_by_owner_name(@user.nickname)
      @repo = Repo.new
      render :show_authenticated
    elsif User.is_the_owner_registered?(params[:owner])
      @user = User.find_by_nickname(params[:owner])
      @repos = Repo.find_all_by_owner_name(@user.nickname)
      @repo = Repo.new
      render :show_registered
    elsif
      @repos = Repo.find_all_by_owner_name(params[:owner])
      @user = User.new(:nickname => params[:owner])
      if @repos.empty? && !octokit_client.check_existence_of(@user) # assumes that all repos in our db correspond to existing user, need to triple check that you cannot under any circumstance create a repo in our db that doesn't exist
        render :show_missing_user
        # TODO: eventually flash notice user doesn't exist instead of rendering page
      else
        render :show
      end
    end

    # respond_to do |format|
    #   format.html # show.html.erb
    #   format.json { render json: @user }
    # end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end


private

def owner_logged_in?
  current_user == User.find_by_nickname(params[:owner])
end

#an attempt to see if the repo has already been loaded

# def repo_uploaded?(repo_name)
#   Repo.find_all_by_owner_name_and_name(params[:owner], repo_name)
# end