class ChainsController < ApplicationController

    def index
        @chains = current_user.chains.sort_by{ |chain| chain.last_message.created_at }.reverse
    end

    def new

    end

    def create

    end

    def show
        @chain = Chain.find(params[:id])
        @friend = @chain.users.reject{ |user| user == current_user}[0]
        @messages = @chain.messages.order("created_at ASC")
        @new_message = Message.new
    end

    def edit

    end

    def update

    end

    def delete

    end

end
