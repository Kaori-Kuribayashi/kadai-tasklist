class MessagesController < ApplicationController
  #タスク一覧
  def index
    @messages = Message.all
  end
  
  #詳細ページ
  def show
    @message = Message.find(params[:id])
  end
  
  #作成ページ
  def new
    @message = Message.new
  end
  
  #newのページから送られてきたフォームの処理
  def create
    @message = Message.new(message_params)
    
    if @message.save
      flash[:success] = 'タスクが正常に追加されました'
      redirect_to @message
    else
      flash.now[:danger] = 'タスクが追加されませんでした'
      render :new
    end
  end
  
  #編集ページ
  def edit
    @message = Message.find(params[:id])
  end
  
  #editのページから送られてきたフォームの処理
  def update
    @message = Message.find(params[:id])
    
    if @message.update(message_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @message
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end
  
  #削除
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    
    flash[:success] = 'タスクは正常に削除されました'
    redirect_to messages_url
  end
  
  private
  
  #Strong Parameter
  def message_params
    params.require(:message).permit(:content)
  end

end
