class MessagesController < ApplicationController

    def index
        @messages = Message.all
    end
    
    def new
        @message = Message.new
    end

    def create

    end

    def show 

    end


    def user_messages
        @messages = Message.all.select{ |message| message.sender_id == current_user.id || message.receiver_id == current_user.id }.sort_by{ |message| message.created_at}
    end


end
