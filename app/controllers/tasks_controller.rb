class TasksController < ApplicationController
  #タスク一覧
  def index
    @tasks = Task.all
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
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = 'タスクが正常に追加されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが追加されませんでした'
      render :new
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
      render :edit
    end
  end
  
  #削除
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  #Strong Parameter
  def task_params
    params.require(:task).permit(:content)
  end
end
