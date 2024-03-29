#encoding:utf-8
class PostsController < ApplicationController
	def index
		if is_admin
			@posts=Post.all
		elsif current_user
			@posts=Post.find(:all, :conditions => { :user_id => current_user.id })
		else
			flash[:error]="管理人権限が必要"
			redirect_to :root
		end
	end
	def new
		@post=Post.new
	end
	def update
		@post = Post.find( params[:id] )
		if @post.update_attributes(params[:post].permit(:title,:content,:tag,:auth))
      	flash[:notice] = '更新成功'
      	redirect_to :root
    	else
      	flash[:error] = '更新失敗'
      	render :edit
    	end
	end
	def show
		@comment=Comment.new
		@post=Post.find(params[:id])
		@comment.post_id=@post.id
		@post.visited
		@prev = Post.where("created_at < ?", @post.created_at).first
    	@next = Post.where("created_at > ?", @post.created_at).first
	end
	def create
 		@post = Post.new(params[:post].permit(:title, :content,:tag, :auth))
 		@post.user_id=current_user.id
 		if @post.save
 			redirect_to :root
 		else
 			@post
 			render :new
 		end
	end
	def edit
		@post=Post.find(params[:id])
	end
	def destroy
		@post=Post.find(params[:id])
		if @post.delete
			flash[:notice]="削除成功"
		redirect_to :root
		end
	end
	 

end
