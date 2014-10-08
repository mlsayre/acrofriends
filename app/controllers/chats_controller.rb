class ChatsController < ApplicationController
  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.create!(chat_params)

    if @chat.save
      #only the last 30 chat messages per group room
      Chat.where(:group_id => params[:chat][:group_id])
        .destroy_all(['id NOT IN (?)', Chat.last(25)])
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def chat_params
      params.require(:chat).permit(:message, :group_id, :user_id)
    end
end
