module Api
    module V1
        class PostsController < ApplicationController
            # Authenticate all of our posts routes
            before_action :authorize_request
            
            has_scope :title
            has_scope :category

            # This method returns all the Posts in the database
            def index 
                post = apply_scopes(Post).order('created_at DESC');
                render json: {
                    status: 'Success',
                    message: 'All Posts',
                    data: post,
                    },
                    status: :ok
            end

            # Create a new post
            def create
                post = Post.new(post_params)
                    if post.save
                        render json: {
                            status: 'Success',
                            message: 'Post saved',
                            data: post,
                            },
                            status: :created
                    else 
                        render json: {
                            status: 'Error',
                            message: 'Post not saved',
                            data: post.errors,
                            },
                            status: :unprocessable_entity
                    end
            end

            # Returns a single post associated with that id
            def show
                begin
                    post = Post.find(params[:id])
                rescue => e
                    render json: { message: 'Post not found' }, status: :not_found
                else
                render json: {
                    status: 'Success',
                    message: 'Loaded post',
                    data: post,
                    },
                    status: :ok
                end
            end

            # Update a post associted with that id in the database
            def update
                begin
                    post = Post.find(params[:id])
                rescue => exception
                   render json: { message: 'Post not found' }, status: :not_found
                else
                    if post.update(post_params)
                        render json: {
                            status: 'Success',
                            message: 'Post updated',
                            data: post
                            },
                            status: :ok
                    else 
                        render json: {
                            status: 'Success',
                            message: 'Post not updated',
                            data: post,
                            },
                            status: :unprocessable_entity
                    end
                end
            end

            # Delete a post from the database
            def destroy
                begin
                    post = Post.find(params[:id])
                rescue => exception
                   render json: { message: 'Post not found' }, status: :not_found 
                else
                    post.destroy
                    render json: {
                        status: 'Success',
                        message: 'Post deleted',
                        data: post,
                        },
                        status: :ok
                end
                
            end

            #show only deleted posts
            def only_deleted
                posts = Post.only_deleted
                render json: {
                    data: posts
                },
                status: :ok
                
            end

            private 
            def post_params
                params.permit(:title, :content, :image, :category, :user_id)
            end
        end
    end
end
