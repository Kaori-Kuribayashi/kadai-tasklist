class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:index, :show, :edit, :update, :destroy]
  
  #タスク一覧
  def index
    @tasks = Task.all.page(params[:page]).per(5)
  end
  
  #詳細ページ
  def show
    @task = Task.find(params[:id])
  end
  
  #作成ページ
  def new
    @task = Task.new
  end
  
  #newのページから送られてきたフォームの処理
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクが正常に追加されました'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'タスクが追加されませんでした'
      render 'toppages/index'
    end
  end
  
  #編集ページ
  def edit
    @task = Task.find(params[:id])
  end
  
  #editのページから送られてきたフォームの処理
  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      redirect_back(fallback_location: root_path)
    end
  end
  
  #削除
  def destroy
    @task.destroy
    flash[:success] = 'タスクを削除しました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  #Strong Parameter
  def task_params
    params.require(:task).permit(:status, :content)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
