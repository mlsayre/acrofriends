class ChatsController < ApplicationController
  before_filter :emoji, :only => [ :create ]

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

  protected

  def emoji
    #first strip img tags from neverdowell chatters
    params[:chat][:message].sub!("<img", "")
    #then see if they want to use emoji
    allemoji = []
    @emojipic = '<img class="emoji" src="/assets/emoji/smile.png">'
    params[:chat][:message].sub!(":smile:", "#{ @emojipic }")
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def chat_params
      params.require(:chat).permit(:message, :group_id, :user_id)
    end
end
