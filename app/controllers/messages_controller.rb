class MessagesController < ApplicationController

    def index
        @current_user = current_user
        @messages = Message.all
    end
    
    def new
        @current_user = current_user
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
            if @chain = Chain.get_message_chain(@sender_id, @receiver_id)
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

    #working
    # def create
    #     @message = Message.new(message_params)
    #     @message.save
    #     redirect_to chain_path(params[:message][:chain_id])
    # end

    def show

    end

    private
    
    def message_params
        params.require(:message).permit(:sender_id, :receiver_id, :content, :chain_id)
    end

end
