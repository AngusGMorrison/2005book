class MessagesController < ApplicationController

    def index
        @messages = Message.all
    end
    
    def new
        @message = Message.new
    end

    def create
        if params[:message][:chain_id] # if this is a message reply to an existing chain... 
            @message = Message.new(message_params)
            @message.save
        else #else, if this is a new message NOT responding to a chain...
            @sender_id = params[:message][:sender_id].to_i
            @receiver_id = params[:message][:receiver_id].to_i
            # if there is an existing chain...
            if @chain = Chain.all.find{ |chain| chain.last_message.sender_id == (@sender_id || @receiver_id) && chain.last_message.receiver_id == (@receiver_id || @sender_id) } 
                @chain #save the instance of the existing chain
            else
                # else, create a new chain
                @chain = Chain.create()
            end
            @message = Message.new(message_params)
            @message.chain_id = @chain.id
            @message.save
        end
        redirect_to chain_path(@message.chain_id)
    end

    def show

    end

    private
    
    def message_params
        params.require(:message).permit(:sender_id, :receiver_id, :content, :chain_id)
    end

end
