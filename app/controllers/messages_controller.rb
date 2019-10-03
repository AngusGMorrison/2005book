class MessagesController < ApplicationController

    def index
      @messages = Message.all
    end
    
    def new
        @message = Message.new
    end

    def create
        @message = Message.new(message_params)
        @message.save
        redirect_to chain_path(params[:message][:chain_id])
    end

    def show

    end

    private
    
    def message_params
        params.require(:message).permit(:sender_id, :receiver_id, :content, :chain_id)
    end

end
