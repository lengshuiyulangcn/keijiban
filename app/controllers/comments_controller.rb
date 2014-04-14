#encoding:utf-8
class CommentsController < ApplicationController
	def create
		@comment = Comment.new(params[:comment].permit(:content,:post_id))
		if current_user==nil
			flash[:error]="回复需要登录"
			redirect_to :login
		else
			@comment.user_id=current_user.id
			if @comment.save
				redirect_to post_path(@comment.post_id)
			else
				@comment
				render post_path(@comment.post_id)
			end
		end
	end
end
