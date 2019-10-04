class ChainsController < ApplicationController

    def index
        @current_user = current_user
        @chains = @current_user.chains
    end

    def new

    end

    def create

    end

    def show
        @current_user = current_user
        @chain = Chain.find(params[:id])
        @friend = @chain.users.reject{ |user| user == current_user}[0]
        @messages = @chain.messages.order("created_at DESC")
        @new_message = Message.new
    end

    def edit

    end

    def update

    end

    def delete

    end

end
